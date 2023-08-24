{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
  ];

  network.hostId = "aa38a832";  # 32-bit host ID in hex. Required by ZFS. Run: $ head -c 8 /etc/machine-id

  boot.initrd.supportedFilesystems = ["zfs"];
  boot.supportedFilesystems = ["zfs"];
  boot.loader.grub.copyKernels = true;   # Similar for systemd-boot ?
  #boot.kernelParams = ["nohibernate"];

  boot.zfs = {
    allowHibernation = true;
    autoSnapshot.enable = true;
    enable = true;
    enableUnstable = true;
    forceImportAll = false;      # Forcibly import all ZFS pools. If false & NixOS fails to import non-root pools, manually import w/ `zpool import -f <poolName>` & reboot. Only should be necessary once.
    forceImportRoot = false;     # Recommended=false, default=true
    requestEncryptionCredentials = true;  # true=Req enc keys/passwords for all enc datasets. Pass list of dataset names to only decrypt some.


    #extraPools = [    # Name / GUID of extra ZFS pools to import during boot.
    #  "containers"    #  usually not necessary. Instead you should set the mountpoint
    #];                #  property of ZFS filesystems to `legacy` & add the ZFS filesystems
    #                  #  to NixOS's `fileSystems` option, which makes NixOS auto import the
    #                  #  associated pool. Use this option if you want to exclusively use ZFS
    #                  #  commands to manage filesystems instead of NixOS/systemd.

    #autoSnapshot.flags = [];
    #devNodes = "/dev/disk/by-id";
    #passwordTimeout = 0;         # Seconds to wait for password entry to decrypt at boot
    #package = pkgs.zfsUnstable;  # set by enableUnstable
    #removeLinuxDRM = true;      # Brings some kernel symbols dropped in 6.2. If kernel configured w/ `zfs.latestCompatibleLinuxPackages`,
    #                            #  you will need to also pass `removeLinuxDRM` to that package. Default=false.
    #kernelPackages = (pkgs.zfs.override { removeLinuxDRM = pkgs.hostPlatform.isAarch64; }).latestCompatibleLinuxPackages;

  };

  security.pam.zfs = {
    enable = true;
    homes = "rpool/home";   # Prefix of home datasets. Will be concatenated w/ `"/" + <username>` in order to determine home dataset to unlock.
    noUnmount = true;       # Do not unmount home dataset on logout. Default=false
  };
  #security.pam.services.<name>.zfs = true;  # Enable unlocking & mounting of encrypted ZFS home dataset at login.

  services.zfs = {
    autoReplication = {
      enable = false;        # Enable ZFS snapshot replication. Default=false.
      followDelete = true;   # Remove remote snapshots that dont have a local correspondent. Default=true
      #host = "<hostname>";  # Remote host where snapshots should be sent. `lz4` expected to be installed on remote host.
      #identityFilePath = "/home/${user}/.ssh/id_rsa";  # Path to SSH key to login to replication host.
      #localFilesystem = "pool/file/path";  # Local ZFS FS from which snapshots should be sent. Defaults to the attribute name.
      #remoteFilesystem = "pool/file/path";  # Remote ZFS FS where snapshots should be sent to.
      recursive = true;      # Recursively discover snapshots to send. Default=true
      username = user;
    };
    autoScrub = {
      enable = true;  # Enable periodic scrubbing of ZFS pools
      interval = "Sun, 02:00";
      pools = [ "tank" ];
    };
    autoSnapshot = {
      enable = true;     # Number of <period>  auto-snapshots that you wish to keep. Default=4
      frequent = 4;      #           15-minute. Default=4
      hourly = 24;       #              hourly. Default=24
      daily = 7;         #               daily. Default=7
      weekly = 4;        #              hourly. Default=4
      monthly = 12;      #              hourly. Default=12
      flags = "-k -p";   # Flags to pass to `zfs-auto-snapshot` command. Run `zfs-auto-snapshot` w/o args to see available flags. D:'-k -p'
    };
    expandOnBoot = "all";    # Expand each device in the specified pool after import. Options: all | disabled | List<zfsPools>
    trim.enable = true;
    trim.interval = "weekly";
  };

}
