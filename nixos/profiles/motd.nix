{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  # --- Message of the Day (MotD) ---
  # Options:
  # - programs.rust-motd = { <rust-motd_config> };
  # - users.motd = "<MOTD_TEXT>";
  # - users.motdFile = <PATH>;
  # - security.duosec.motd = true;
  # - security.pam.services.<name>.showMotd = true;
  # - services.charybdis.motd = "<MOTD_TEXT>"
  # - services.crossfire-server.configFiles.motd = "<MOTD_TEXT>";
  # - services.mchprs.settings.motd = "<MOTD_TEXT>";
  # - services.prosody.modules.motd = "<MOTD_TEXT>";
  # - services.solanium.motd = "<MOTD_TEXT>";
  # - services.teeworlds.motd = "<MOTD_TEXT>";
  # - services.tox-node.motd = "<MOTD_TEXT>";
  # - services.xonotic.settings.sv_motd = "<MOTD_TEXT>";
  programs.rust-motd = {
    enable = lib.mkDefault true;
    enableMotdInSSHD = lib.mkDefault true;
    order = [
      "global"
      "banner"
      "uptime"
      "last_login" # TODO: lib.mkBefore
      "fail_2_ban"
      "filesystems"
      "memory"
      #"ssl_certificates"
      #"service_status"
      #"user_service_status"
      #"docker"
      "weather"
      "last_run" # # TODO: lib.mkAfter?
    ];
    refreshInterval = lib.mkDefault "*:0/5";
    settings = {
      # Apply to all components
      global = {
        progress_full_character = "=";
        progress_empty_character = "=";
        progress_prefix = "[";
        progress_suffix = "]";
        progress_width = lib.mkDefault 40;
        time_format = "%Y-%m-%d %H:%M:%S"; # TODO: relative time format?
      };

      # Display singular banner
      # TODO: Set banner width to function of: `config.programs.rust-motd.settings.global.progress_width`
      # TODO: Set figlet style/font with `-d <font>`
      banner = {
        color =
          lib.mkDefault
          "black"; # black|red|green|yellow|blue|magenta|cyan|white|light<Color>
        command =
          lib.mkDefault
          "echo '${config.networking.hostName}' | ${pkgs.figlet}/bin/figlet -c"; # sh command to generate banner
      };

      # Display status of docker containers.
      # Note: Local containers must start w/ a slash (https://github.com/moby/moby/issues/6705)
      #docker = {
      #  "/nextcloud-nextcloud-1" = "Nextcloud";
      #};

      # Display status of Fail2Ban jails
      #fail_2_ban.jails = lib.mkIf config.services.fail2ban.enable ["sshd"];
      fail_2_ban.jails = with config.services.fail2ban;
        lib.mkIf enable (lib.attrsets.mapAttrsToList (n: v: n) jails);

      # Display filesystem space usage/consumption
      filesystems = {
        root = "/";
        home = "/home";

        # TODO: Auto list elements under /nix/persist
        #nix-persist =
        #  lib.mkIf (config.environment.persistence."/nix/persist")
        #  "/nix/persist";
        nix-store = "/nix/store";
      };

      # Display last login for users in attrset.
      # TODO: Possible to use `config.users.users.extraUsers`, etc.?
      last_login = {
        "${user}" = 5;
        root = 5;
      };

      # Display time of last run of rust-motd
      last_run = {};

      # Display RAM & swap usage
      memory.swap_pos = "beside"; # beside|below|none

      # Display status of systemd system services
      # TODO: Move these to the NixOS profile that enables them.
      #  -- OR --
      # TODO: lib.mkIf services.<name>.enable
      #  -- OR --
      # TODO: Create lib to test `service.<name>.enable`, then create attr `{ <prettyName> = <systemdName>; }`
      # - lib to map item
      # - lib to iterate over list of items
      # - Figure out when services enabled by option not of form: `services.<name>`
      #   mkRenameServiceIfEnabled = s: n: if config.services.${s}.enable then { "${n}" = s; } else {};
      #   mkServiceRenames = lst: lib.foldr (item: acc: acc // (mkRenameServiceIfEnabled (builtins.tail item) (builtins.head item))) {} srv_list_system;
      #service_status = {
      #  Accounts = "accounts-daemon";
      #  AppArmor = "apparmor";
      #  Audit = "audit";
      #  #auditd = "auditd";
      #  Avahi = "avahi-daemon";
      #  Bluetooth = "bluetooth";
      #  D-Bus = "dbus";
      #  Disks = "udisks2";
      #  Containers = "containerd";
      #  CRI-O = "crio";
      #  Firewall = "nftables";
      #  Fingerprint = "fprintd";
      #  "Firmware Update" = "fwupd";
      #  Geoclue = "geoclue";
      #  LibVirt = "libvirtd";
      #  LXD = "lxd";
      #  "Network Manager" = "NetworkManager";
      #  "Nix Daemon" = "nix-daemon";
      #  OOM = "earlyoom"; # "systemd-oomd";
      #  PolicyKit = "polkit";
      #  Podman = "podman";
      #  Printing = "cups";
      #  "Printer Browser" = "cups-browsed";
      #  SSH = lib.mkIf config.services.openssh.enable "sshd";
      #  "SSH Guard" = "sshguard";
      #  systemd-journald = "systemd-journald";
      #  systemd-logind = "systemd-logind";
      #  systemd-machined = "systemd-machined";
      #  systemd-networkd = "systemd-networkd";
      #  systemd-resolved = "systemd-resolved";
      #  systemd-timesyncd = "systemd-timesyncd";
      #  Tailscale = "tailscaled";
      #  upower = "upower";
      #  Waydroid = "waydroid-container";
      #  Wireguard = "wg-netmanager";
      #  "Wireguard SEA1" = "wireguard-wg-sea1";
      #  wpa_supplicant = "wpa_supplicant";
      #};

      # Display SSL certs & renewal times
      #ssl_certificates = {
      #  sort_method = "manual";
      #  certs = {
      #    CertName1 = "/path/to/cert1.pem";
      #    CertName2 = "/path/to/cert2.pem";
      #  };
      #};

      # Display system uptime
      uptime = {prefix = "Uptime: ";};

      # Display status of systemd user services
      #user_service_status = {
      #  "D-Bus" = "dbus";
      #  DConf = "dconf";
      #  "GPG Agent" = "gpg-agent";
      #  GVFS = "gvfs-daemon";
      #  Keyring =
      #    lib.mkIf config.services.gnome.gnome-keyring.enable "gnome-keyring";
      #  MPD = "mdp";
      #  Portals = "flatpak-portal";
      #};

      # Display weather from wttr.in
      weather = {
        loc = "Erie,Pennsylvania";
        style = "day"; # oneline|day|full
        timeout = 5;
        #url = "https://wttr.in/Erie,Pennsylvania?format=4";
        #user_agent = "Mozilla/5.0 ()";
        #proxy = "http://proxy:8080";
      };
    };
  };
}
