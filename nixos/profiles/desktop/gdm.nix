{
  config,
  lib,
  pkgs,
  ...
}:
#let
#  openssh-banner = (config.services.openssh.banner != null) && false;
#in
{
  services.xserver.displayManager.gdm = {
    enable = lib.mkDefault true;

    # Display text on login screen
    # NOTE: Font is not monospaced.
    # TODO: Display MOTD?
    # TODO: Display lastUpdated?
    # TODO: Display nixpkgs version/channel/date/hash?
    banner =
      ''
        Host: ${config.networking.hostName}
      ''
      #--- Welcome! ---------------------
      #  Domain: lehman.run
      #''
      #--- NixOS ------------------------
      # Release: ${config.system.nixos.release} (${config.system.nixos.codeName})
      #Original: ${config.system.stateVersion}
      #Revision: ${config.system.configurationRevision}
      #   Label: ${config.system.nixos.label}
      #----------------------------------
      #Variant: ${config.system.nixos.variant_id ? "main"}
      #Domain: ${config.networking.domain} ? "lehman.run"}
      #Tags: ${builtins.concatStringsSep ", " config.system.nixos.tags}
      #+ (lib.strings.optionalString (config.services.openssh.banner != null)
      #  config.services.openssh.banner)
      #+ (lib.strings.optionalString (config.users.motd != null)
      #config.users.motd)
      ;

    # Login after seconds as autoLogin.user when autoLogin.enable=true;
    #autoLogin.delay = lib.mkDefault 120;

    # Automatically suspend if no login after some time
    #autoSuspend = lib.mkDefault true;

    # Enable debugging
    #debug = lib.mkDefault false;

    # Use Wayland instead of X11
    #wayland = lib.mkDefault true;

    # Options to pass to the GDM daemon.
    # Options: https://help.gnome.org/admin/gdm/stable/configuration.html.en#daemonconfig
    #settings = lib.mkDefault {
    #  debug.enable = false;
    #  daemon = {
    #    TimedLoginEnable = false;
    #    TimedLogin = user;
    #    TimedLoginDelay = 30;
    #    AutomaticLoginEnable = false;
    #    AutomaticLogin = user;
    #  };
    #  greeter = {
    #    IncludeAll = true;
    #    Include = [user "guest"];
    #    Exclude = ["bin" "root" "daemon" "adm" "lp" "sync" "shutdown" "halt" "mail" "news" "uucp" "operator" "nobody" "nobody4" "noaccess" "postgres" "pvm" "rpm" "nfsnobody" "pcap"];
    #  };
    #  security.DisallowTCP = true;
    #  xdmcp = {
    #    DisplaysPerHost = 3;
    #    # NOTE: Also add `gdm:.${config.networking.domain}` to `/etc/hosts.allow`
    #    Enable = true;
    #    HonorIndirect = true;
    #    MaxPending = 4;
    #    MaxSessions = 16;
    #    MaxWait = 30;
    #    MaxWaitIndirect = 30;
    #    PingIntervalSeconds = 60;
    #    Port = 177;
    #    Willing = "/etc/gdm/Xwilling";
    #  };
    #};
  };
}
