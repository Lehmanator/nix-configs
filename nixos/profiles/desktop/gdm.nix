{ config, lib, pkgs, user, ... }:
# let
#   inherit (lib) concatStringsSep mkDefault optionalString;
#   openssh-banner = (config.services.openssh.banner != null) && false;
#   bannerText = with config; ''
#     +---[Welcome!]---------------------+
#     |     Host: ${config.networking.hostName} |
#     |   Domain: ${config.networking.domain or "lehman.run"} |
#     +---[NixOS]------------------------+
#     |  Release: ${system.nixos.release} (${system.nixos.codeName})
#     | Original: ${system.stateVersion}
#     | Revision: ${system.configurationRevision}
#     |    Label: ${system.nixos.label}
#     |  Variant: ${system.nixos.variant_id ? "main"}
#     |     Tags: ${builtins.concatStringsSep ", " nixos.tags}
#     +----------------------------------+
#   '';
#   mkBanner = bannerText + "\n"
#     + optionalString (services.openssh.banner != null) services.openssh.banner
#     + optionalString (             users.motd != null) users.motd             
#   ;
# in
{
  users.users.${user}.extraGroups = ["gdm"];          # Add main user to GDM
  services.xserver.displayManager.gdm.enable = true;  # Enable GDM

  # Display text on login screen
  # NOTE: Font is not monospaced.
  # TODO: Display MOTD?
  # TODO: Display lastUpdated?
  # TODO: Display nixpkgs version/channel/date/hash?
  services.xserver.displayManager.gdm.banner = ''
    Host: ${config.networking.hostName}
  '';

  # services.xserver.displayManager.gdm = {
  #   autoLogin.delay = mkDefault 120;    # Delay autoLogin when enabled
  #   autoSuspend     = mkDefault true;   # Suspend if no login after time
  #   debug           = mkDefault false;  # Enable GDM debugging
  #   wayland         = mkDefault true;   # Use Wayland for GDM instead of X11
  # };

  # GDM Daemon settings - `/etc/gdm/custom.conf`
  #  Options: https://help.gnome.org/admin/gdm/stable/configuration.html.en#daemonconfig
  # services.xserver.displayManager.settings = mkDefault {
  #   debug.enable = false;              # Set by debug
  #
  #   daemon = {
  #     TimedLoginEnable     = false;    # Set by autoSuspend
  #     TimedLogin           = user;     # Set by autoSuspend
  #     TimedLoginDelay      = 30;       # Set by autoLogin.delay
  #     AutomaticLoginEnable = false;    # Set by autoLogin.enable
  #     AutomaticLogin       = user;     # Set by autoLogin.user
  #   };
  #
  #   chooser = {    # If IPv6 enabled,  # Collect multicast network hosts resps
  #     Multicast           = false;     # Send multicast query to local network
  #     MulticastAddr       = "ff02::1"; # Link-local multicast address
  #   };
  #
  #   greeter = {
  #     IncludeAll = true;                   # Include all users (w/ UID > 500)
  #     Include = concatStringsSep "," [user "guest"]; # UI: Incl users (force)
  #     Exclude = concatStringsSep "," [               # UI: Excl users
  #       "bin"  "root" "daemon"    "adm"    "shutdown" "sync"
  #       "news" "uucp" "operator"  "nobody" "nobody4"  "noaccess" "halt"
  #       "pvm"  "rpm"  "nfsnobody" "pcap"   "postgres" "mail"
  #     ];
  #   };
  #
  #   # Disallow TCP connections when starting attached Xservers.
  #   #  More secure if not using remote connections
  #   security.DisallowTCP = true;  
  #
  #   # XDMCP support allows remote displays/X terminals to be managed by GDM
  #   xdmcp = {
  #     # NOTE: Also add `gdm:.${config.networking.domain}` to `/etc/hosts.allow`
  #     Enable              = true; # Listen on UDP port 177 (or value below)
  #     HonorIndirect       = true; # Remote execd gdmchooser (X-Term w/o display browser)
  #     DisplaysPerHost     = 4;    # Connections per remote computer.
  #     MaxPending          = 4;    # Max simult started displays (to thwart DOS)
  #     MaxSessions         = 12;   # Max simult display connections
  #     MaxWait             = 30;   # Sec w/o resp before drops pending display
  #     MaxWaitIndirect     = 30;   #
  #     PingIntervalSeconds = 60;   # Sec w/o Xserver resp before ending session
  #     Port                = 177;  # UDP port GDM should listen for XDMCP reqs on
  #     Willing             = "/etc/gdm/Xwilling";  # Script to gen status message to send
  #   };
  # };

  # networking.firewall.allowedUDPPorts = with config.services.xserver.displayManager.gdm.settings; mkIf xdmcp.enable [xdmcp.Port];

  # environment.etc = mkIf config.services.xserver.displayManager.gdm.settings.xdmcp.enable {
  #   "hosts.allow".text = ''
  #     gdm:.${config.networking.domain}
  #   '';
  #   # "gdm/Xwilling".text = ''
  #   # '';
  # };

  # Admin user: Add configurator package & DConf Nix util
  home-manager.users.${user}.home.packages = [pkgs.gdm-settings pkgs.dconf2nix];
}
