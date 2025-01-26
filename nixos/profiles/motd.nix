{
  config,
  lib,
  pkgs,
  user,
  ...
}: let
  inherit (lib) mkDefault mkIf optional optionalAttrs unique;
in {
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
    enable = mkDefault true;

    # Let OpenSSH print MotD when entering new SSH session.
    # Incompatible w/ opt: users.motd
    enableMotdInSSHD = mkDefault true;

    order =
      ["global" "banner" "weather" "uptime" "last_login"]
      ++ (optional (config.services.fail2ban.enable) "fail2_ban")
      ++ ["filesystems" "memory"]
      #++ (with config.security.acme; optional (acceptTerms && (builtins.length (builtins.attrNames certs) > 0)) "s_s_l_certs" # old: "ssl_certificates"
      ++ ["service_status" "user_service_status"]
      #++ (with config.virtualisation; lib.optional (docker.enable || podman.enable) "docker")
      ++ [
        "last_run"
      ];
    refreshInterval = mkDefault "*:0/5";
    settings =
      {
        # Applies to all components
        global = let
          get-caps = n:
            if builtins.isString
            then {
              progress_prefix = charsets.caps.${n};
              progress_suffix = charsets.caps.${n};
            }
            else {
              progress_prefix = builtins.elemAt charsets.caps.${n} 0;
              progress_suffix = builtins.elemAt charsets.caps.${n} 1;
            };
          mapChars = n: {
            progress_prefix = builtins.elemAt charsets.${n} 0;
            progress_full_character = builtins.elemAt charsets.${n} 1;
            progress_empty_character = builtins.elemAt charsets.${n} 2;
            progress_suffix = builtins.elemAt charsets.${n} 3;
          };
          show-seconds = false;
          emptys = {
            none = " ";
            low = "░";
            med = "▒";
            dark = "▓";
            full = "█";
          };
          charsets = {
            caps = {
              none = "";
              space = " ";
              thin = ["▕" "▏"];
              thick = ["┃" "┃"];
              nobs = ["─╢" "╟─"];
              curve-up = ["╰─╢" "╟─╯"];
              curve-down = ["╭─╢" "╟─╮"];
              curve-2-down = ["╭─┤" "├─╮"];
              brackets = ["[" "]"];
            };
            equals = ["[" "=" "=" "]"];
            block-thin-center = ["[" "■" " " "]"];
            block-thin-top = ["[" "▀" " " "]"];
            block-thin-bottom = ["[" "▄" " " "]"];
            block-thick-caps-none = ["" "█" "░" ""];
            block-thick-caps-thin = ["▕" "█" "░" "▏"];
            block-thick-caps-thick = ["┃" "█" "░" "┃"];
            block-thick-caps-nobs = ["╢" "█" "░" "╟"];
            # Shade Levels:  ░  ▒  ▓  █
          };
        in
          (mapChars "block-thin-center")
          // {
            progress_width = mkDefault 40;
            time_format = "%Y-%m-%d %H:%M" + (lib.optionalString show-seconds ":%S"); # TODO: relative time format?
          };

        # (if block then {
        #   progress_full_character = "█";
        #   progress_empty_character = "░";
        #   progress_prefix = "┃";
        #   progress_suffix = "┃"; # "╟";
        # } else {
        #   progress_full_character = "=";
        #   progress_empty_character = "=";
        #   progress_prefix = "[";
        #   progress_suffix = "]";
        # });
        #■■■■■■■■■

        # Display singular banner
        # TODO: Set banner width to function of: `config.programs.rust-motd.settings.global.progress_width`
        # TODO: Set figlet style/font with `-d <font>`
        banner = {
          color = mkDefault "black"; # black|red|green|yellow|blue|magenta|cyan|white|light<Color>
          command = mkDefault "echo '${config.networking.hostName}' | ${pkgs.figlet}/bin/figlet"; #-c";
        };

        # Display status of docker containers.
        # Note: Local containers must start w/ a slash (https://github.com/moby/moby/issues/6705)
        #docker = {
        #  "/nextcloud-nextcloud-1" = "Nextcloud";
        #};

        # Display filesystem space usage/consumption
        # TODO: Auto list elements under /nix/persist
        filesystems = {
          root = "/";
          home = "/home";
          nix-store = "/nix/store";
          #nix-persist = mkIf (config.environment.persistence."/nix/persist/system") "/nix/persist";
        };

        # Display last login for users in attrset.
        # TODO: Possible to use `config.users.users.extraUsers`, etc.?
        last_login = {
          root = 4;
          ${user} = 4;
        };
        last_run = {}; # Display time of last run of rust-motd

        # Display RAM & swap usage
        memory.swap_pos = "below"; # beside|below|none

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
        service_status = {
          Accounts = mkIf config.services.xserver.enable "accounts-daemon";
          "D-Bus System" = "dbus-broker";
          Containers = mkIf config.virtualisation.containerd.enable "containerd";
          CRI-O = mkIf config.virtualisation.cri-o.enable "crio";
          Firewall = "nftables";
          "Network Manager" = mkIf config.networking.networkmanager.enable "NetworkManager";
          "Nix Daemon" = "nix-daemon";
          PolicyKit = "polkit";
          Podman = mkIf config.virtualisation.podman.enable "podman";
          "SSH Daemon" = mkIf config.services.openssh.enable "sshd";
          "SSH Guard" = mkIf config.services.sshguard.enable "sshguard";
          systemd-logind = "systemd-logind";
          systemd-networkd = "systemd-networkd";
          Tailscale = "tailscaled";
          Waydroid = mkIf config.virtualisation.waydroid.enable "waydroid-container";
          "Wireguard SEA1" = "wireguard-wg-sea1";
          #  AppArmor = "apparmor";
          #  Audit = "audit";
          #  #auditd = "auditd";
          #  Avahi = "avahi-daemon";
          #  Bluetooth = "bluetooth";
          #  Disks = "udisks2";
          #  "Firmware Update" = "fwupd";
          #  Geoclue = "geoclue";
          #  LibVirt = "libvirtd";
          #  LXD = "lxd";
          #  OOM = "earlyoom"; # "systemd-oomd";
          #  Printing = "cups";
          #  "Printer Browser" = "cups-browsed";
          #  systemd-journald = "systemd-journald";
          #  systemd-machined = "systemd-machined";
          #  systemd-resolved = "systemd-resolved";
          #  systemd-timesyncd = "systemd-timesyncd";
          #  upower = "upower";
          #  Wireguard = "wg-netmanager";
          #  wpa_supplicant = "wpa_supplicant";
        };

        # Display SSL certs & renewal times
        #ssl_certificates = {
        #  sort_method = "manual";
        #  certs = {
        #    CertName1 = "/path/to/cert1.pem";
        #    CertName2 = "/path/to/cert2.pem";
        #  };
        #};

        # Display system uptime
        uptime.prefix = "Uptime: ";

        # Display status of systemd user services
        user_service_status = {
          "D-Bus Session" = "dbus";
          "GPG Agent" = "gpg-agent";
          GVFS = "gvfs-daemon";
          # DConf = "dconf";
          # Keyring = lib.mkIf config.services.gnome.gnome-keyring.enable "gnome-keyring";
          # MPD = "mdp";
          # Portals = "flatpak-portal";
        };

        # Display weather from wttr.in
        # https://github.com/chubin/wttr.in
        weather = let
          glyph-type = "emoji"; # emoji | nerdfont | unicode | ascii
          extra-data = true;
          format = "v2"; #
        in rec {
          # loc = "Erie";  #"Erie,Pennsylvania";
          # style = "day"; # oneline|day|full
          timeout = 5;
          url = "https://en.wttr.in/Erie?format=3";
          # url = "https://en.wttr.in/Erie?u&format=3";
          #user_agent = "Mozilla/5.0 ()";
          #proxy = "http://proxy:8080";
        };
      }
      // optionalAttrs config.services.fail2ban.enable {
        # Display status of Fail2Ban jails
        #fail2_ban.jails = lib.mkIf config.services.fail2ban.enable ["sshd"];
        fail_2_ban.jails = unique (["sshd"] ++ (builtins.attrNames config.services.fail2ban.jails));
      };
  };
}
