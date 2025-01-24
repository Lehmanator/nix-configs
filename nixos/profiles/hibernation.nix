{ inputs, config, lib, pkgs, ... }:
#
# TODO: Possible to work with machines that are Kubernetes nodes?
# TODO: Setup Full Disk Encryption (FDE) before enabling swap & hibernation.
# TODO: Encrypt keyfiles with agenix or sops-nix, then add to repo.
#  - [ ] Use primary keyfile to decrypt root partition.
#  - [ ] Store keyfiles for other partitions on root partition?
#  - [ ] Mount other keyfiles at proper location on disk.
# TODO: Configure hardware-configuration & disk partitions with Disko.
#
# See:
#
# - https://nixos.wiki/wiki/Laptop
# - https://sawyershepherd.org/post/hibernating-to-an-encrypted-swapfile-on-btrfs-with-nixos/
#
{
  # imports = [ ./swap.nix ];

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

  # Options: lock | reboot | poweroff | hybrid-sleep | suspend-then-hibernate
  #          halt | kexec  | suspend  | hibernate    | 
  services.logind = {
    hibernationKey          = "hibernate";
    hibernationKeyLongPress = "suspend-then-hibernate";
    lidSwitch               = "suspend";
    lidSwitchDocked         = "ignore";
    lidSwitchExternalPower  = config.services.logind.lidSwitch; # "ignore";
    suspendKey              = "suspend";
    suspendKeyLongPress     = "hibernate";
  };

  services.physlock.lockOn.hibernate = true;
  services.upower.criticalPowerAction = "Hibernate"; # PowerOff | Hibernate | HybridSleep (default)

  # The swap devices and swap files. These must have been initialised using mkswap.
  #  Each element should be an attribute set specifying either:
  #  - the path of the swap device or file (device) or
  #  - the label of the swap device (label, see mkswap -L).
  #  Using a label is recommended.
  swapDevices.primary-swap = {
    device        = "/dev/nvme0n1p2"; # Path of the device or swap file.
    discardPolicy = null;             # null | once | pages | both
    label         = "swap";           # Label of the device. Can be used instead of device.
    options       = [ "defaults" ];   # Options used to mount the swap.
    priority      = 10;               # Priority of swap device [0,32767] where higher number => higher priority. null lets kernel choose priority, which will show as negative value
    size          = 2048;             # Swap size in Megabytes.                # TODO: Set to RAM size * 1.5

    # --- Swap Encryption ---
    # label:   Label of unlocked encrypted device. 
    #           Set:`fileSystems.<name?>.device`=`/dev/mapper/<label>` to mount unlocked device
    # keyFile: Path to keyfile to unlock backing encrypted device. When keyfile accessed,
    #           `fileSystems.<name?>.neededForBoot` FSs will have been mounted in `/mnt-root`,
    #           so keyfile path prob starts w/ `/mnt-root/`.
    randomEncryption.enable = lib.mkForce false;
    encrypted = {
      enable  = true;                      # Block device backed by encrypted one, adds this device as initrd luks entry
      blkDev  = "/dev/nvme0n1p2";          # Location of backing encrypted device.
      keyFile = "/mnt-root/root/.swapkey";
      label   = "swap";
    };
  };

  # If you have issues w/ device not shutting off after hibernating, uncomment these lines:
  #systemd.sleep.extraConfig = ''
  #  [Sleep]
  #  HibernateMode=shutdown
  #'';
}

