{ inputs
, config
, lib
, pkgs
, ...
}:
# TODO: Possible to work with machines that are Kubernetes nodes?
# TODO: Setup Full Disk Encryption (FDE) before enabling swap & hibernation.
# TODO: Encrypt keyfiles with agenix or sops-nix, then add to repo.
#  - [ ] Use primary keyfile to decrypt root partition.
#  - [ ] Store keyfiles for other partitions on root partition?
#  - [ ] Mount other keyfiles at proper location on disk.
# TODO: Configure hardware-configuration & disk partitions with Disko.
#
#
# See:
#
# - https://nixos.wiki/wiki/Laptop
# - https://sawyershepherd.org/post/hibernating-to-an-encrypted-swapfile-on-btrfs-with-nixos/
#
{
  imports = [
    #./swap.nix
  ];

  # Device for manual resume attempt during boot.
  #  This should be used primarily if you want to resume from file.
  #  If left empty, the swap partitions are used.
  #  Specify here the device where the file resides.
  #  You should also use boot.kernelParams to specify «resume_offset».

  boot = {
    # TODO: Other hardware-configuration settings
    # TODO: initrd LUKS disk unlock?
    # TODO: initrd swap?
    # TODO: swapDevices?
    # TODO: swap LUKS encryption?
    # TODO: neededForBoot on parent filesystem when using swapfile?
    # TODO: Both physical & Zram swap possible together?
    #resumeDevice = "/dev/nvme0n1p2";
    #kernelParams = ["resume_offset=<uInt>"];
    #kernelModules = [];
    #initrd = {
    #  availableKernelModules = [];
    #  kernelModules = [];
    #};
    zfs.allowHibernation = lib.mkIf config.boot.zfs.enable true;
  };

  services.logind = {
    hibernationKey = "hibernate";
    hibernationKeyLongPress = "suspend-then-hibernate"; # “ignore”, “poweroff”, “reboot”, “halt”, “kexec”, “suspend”, “hibernate”, “hybrid-sleep”, “suspend-then-hibernate”, “lock”
    lidSwitch = "suspend";
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = config.services.logind.lidSwitch; #"ignore";
    suspendKey = "suspend"; # “ignore”, “poweroff”, “reboot”, “halt”, “kexec”, “suspend”, “hibernate”, “hybrid-sleep”, “suspend-then-hibernate”, “lock”
    suspendKeyLongPress = "hibernate"; # “ignore”, “poweroff”, “reboot”, “halt”, “kexec”, “suspend”, “hibernate”, “hybrid-sleep”, “suspend-then-hibernate”, “lock”
  };

  services.physlock.lockOn.hibernate = true;
  services.upower.criticalPowerAction = "Hibernate"; # PowerOff | Hibernate | HybridSleep (default)

  # The swap devices and swap files. These must have been initialised using mkswap.
  #  Each element should be an attribute set specifying either:
  #  - the path of the swap device or file (device) or
  #  - the label of the swap device (label, see mkswap -L).
  #  Using a label is recommended.
  swapDevices = {

    primary-swap = {

      # --- Swap device parameters ---
      device = "/dev/nvme0n1p2"; # Path of the device or swap file.
      discardPolicy = null; # null | once | pages | both
      label = "swap"; # Label of the device. Can be used instead of device.
      options = [ "defaults" ]; # Options used to mount the swap.
      priority = 10; # Priority of the swap device b/w [0, 32767] where higher number => higher priority. null lets kernel choose priority, which will show up as negative value.
      size = 2048; # Swap size in Megabytes.                # TODO: Set to RAM size * 1.5

      # --- Swap Encryption ---
      encrypted = {
        enable = true; # The block device is backed by an encrypted one, adds this device as a initrd luks entry.
        blkDev = "/dev/nvme0n1p2"; # Location of the backing encrypted device.
        # Path to a keyfile used to unlock the backing encrypted device.
        #  At the time this keyfile is accessed,
        #   the neededForBoot filesystems (see fileSystems.<name?>.neededForBoot) will have been mounted under /mnt-root,
        #   so the keyfile path should usually start with “/mnt-root/”.
        keyFile = "/mnt-root/root/.swapkey";

        # Label of the unlocked encrypted device. Set fileSystems.<name?>.device to /dev/mapper/<label> to mount the unlocked device.
        label = "swap";
      };

      # --- Swap Random Encryption ---
      # Encrypt swap device with a random key. This way you won’t have a persistent swap device.
      #  HINT: run `cryptsetup benchmark` to test cipher performance on your machine.
      #  WARNING: Don’t try to hibernate when you have at least one swap partition with this option enabled!
      #    We have no way to set the partition into which hibernation image is saved, so if your image ends up on an encrypted one you would lose it!
      #  WARNING: Do not use /dev/disk/by-uuid/… or /dev/disk/by-label/… as your swap device when using randomEncryption
      #   ...as the UUIDs & labels will get erased on every boot when the partition is encrypted.
      #   Best to use /dev/disk/by-partuuid/…
      randomEncryption = {
        enable = false; # Encrypt swap with random data. Note: cannot be used w/ hibernate!
        allowDiscards = false; # Harden: set false.
        cipher = "aes-xts-plain64"; #
        keySize = "512"; # If null, will be determined by cryptsetup. See: cryptsetup-open(8)
        sectorSize = "4096"; #  If null, will be determined by cryptsetup. See: cryptsetup-open(8)
        source = "/dev/urandom"; # /dev/random
      };

    };

  };

  # If you have issues w/ device not shutting off after hibernating, uncomment these lines:
  #systemd.sleep.extraConfig = ''
  #  [Sleep]
  #  HibernateMode=shutdown
  #'';



}

