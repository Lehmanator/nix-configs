{ inputs, self, config, lib, pkgs, ...
}:
{
  imports = [
  ];

  boot.initrd.systemd = {
    enable = true;
    #package = pkgs.systemdStage1;
    dbus.enable = true;
    emergencyAccess = false;   # false | true | null | <str> (hashed superuser password to lock emergency mode behind auth)

    # Extra config options for systemd. See: $ man systemd-system.conf(5)
    #extraConfig = "DefaultLimitCORE=infinity";


    # --- systemd environment ---
    # Env vars of PID 1. These are **not** passed to started units.
    managerEnvironment = {
      SYSTEMD_LOG_LEVEL = "debug";
    };

    #users = {
    #  <name> = { group = config.users.users.<name>.group; uid = 1001; };
    #};
    #groups = {
    #  users = { gid = config.users.groups.users.gid; };
    #};

    # --- systemd initrd copy ---
    # Packages to include in /bin for the stage 1 emergency shell.
    initrdBin = [];

    #extraBin = {
    #  umount = "${pkgs.util-linux}/bin/umount";
    #};

    #contents = {
    #  "/etc/hostname" = {
    #    text = config.networking.hostName ? "fw";
    #    enable = true;
    #    source = "/etc/hostname";
    #    target = "/etc/hostname";
    #  };
    #};
    strip = true;      # Completely strip executables & libs copied into initramfs. Saves ~30MiB in build, ~1MiB of initramfs size.
    storePaths = [];
    suppressedStorePaths = [];  # Store paths specified in the `storePaths` option that should not be copied.
    suppressedUnits = [];       # List of units to skip when generating system systemd configuration directory. Has priority over upstream units, `boot.initrd.systemd.units`, & `boot.initrd.systemd.additionalUpstreamUnits`. Main purpose = prevent upstream systemd unit from being added to the initrd w/o modifications made by other NixOS modules.

    # --- systemd unit files ---
    # Definition of systemd units to be available in initrd
    additionalUpstreamUnits = [      # Units to borrow from upstream for usage in initrd.
      "debug-shell.service"
      "systemd-quotacheck.service"
    ];
    automounts = []; # systemd automount unit definitions.
    mounts = [ ];    # systemd mount     unit definitions.
    paths = {};      # systemd path      unit definitions.
    services = {};   # systemd service   unit definitions.
    slices = {};     # systemd slice     unit definitions.
    sockets = {};    # systemd socket    unit definitions.
    targets = {};    # systemd target    unit definitions.
    timers = {};     # systemd timer     unit definitions.
    units = {};      # systemd generic   unit definitions.

    # --- systemd-networkd in initrd ---
    network = {
      enable = true;  # Enable systemd-networkd in initram.          # TODO: Set to `systemd-networkd.enable`
      config = {};    # Definition of global systemd network config.
      links = {};     # Definition of systemd network links.
      netdevs = {};   # Definition of systemd network devices.
      networks = {};  # Definition of systemd networks.
      wait-online = {         # Enable `systemd-networkd-wait-online` service. Can timeout & fail if there arent network interfaces available to manage.
        enable = false;       #  This service can be disabled when service other than systemd-networkd is responsible for managing system’s internet connection (e.g. NetworkManager/connman manage WiFi connections)
        anyInterface = true;  #  Consider network online when any interface is online, vs. **all of them**. Useful on portable devices w/ both wired & wireless interface.
        extraArgs = [];       # Extra CLI args to pass to `systemd-networkd-wait-online`. Also effect per-interface `systemd-networkd-wait-online@` services. See: man systemd-networkd-wait-online.service(8) for options.
        ignoredInterfaces = ["wg0"];  # Network interfaces to be ignored when deciding if the system is online.
        timeout = 120;
      };
    };


    # --- systemd-repartd disk partitioning ---
    # TODO: Consider enabling `systemd-repart` in a separate file: `./boot/systemd-repart.nix`
    repart = {                           # Grow & add partitions to table at boot time in initrd using `systemd-repart` (note: only works w/ GPT part tables)
      enable = true;                     # If device=null, systemd-repart will operate on the device backing the root partition.
      device = null;   #"/dev/nvme0n1";  #   So in order to dynamically create the root partition in the initrd, you need to set a device.
    };

  };

}
