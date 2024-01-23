{
  config,
  lib,
  pkgs,
  ...
}: let
  openssh-banner = (config.services.openssh.banner != null) && false;
in {
  services.xserver.displayManager.gdm = {
    enable = lib.mkDefault true;

    # TODO: Display MOTD?
    # TODO: Display lastUpdated?
    # TODO: Display nixpkgs version/channel/date/hash?
    banner =
      ''
        --- Welcome! ---------------------
            Host: ${config.networking.hostName}
          Domain: ${config.networking.domain}
        --- NixOS ------------------------
         Release: ${config.system.nixos.release} (${config.system.nixos.codeName})
        Original: ${config.system.stateVersion}
         Variant: ${config.system.nixos.variant_id ? "main"}
        Revision: ${config.system.configurationRevision}
           Label: ${config.system.nixos.label}
            Tags: ${builtins.concatStringsSep ", " config.system.nixos.tags}
        ----------------------------------
      ''
      + (lib.strings.optionalString (config.services.openssh.banner != null)
        config.services.openssh.banner)
      + (lib.strings.optionalString (config.users.motd != null)
        config.users.motd);

    # Login after seconds as autoLogin.user when autoLogin.enable=true;
    autoLogin.delay = lib.mkDefault 120;

    # Automatically suspend if no login after some time
    autoSuspend = lib.mkDefault true;

    # Enable debugging
    debug = lib.mkDefault true;

    # Use Wayland instead of X11
    wayland = lib.mkDefault true;

    # Options to pass to the GDM daemon.
    # Options: https://help.gnome.org/admin/gdm/stable/configuration.html.en#daemonconfig
    settings = lib.mkDefault {debug = {enable = true;};};
  };
}
