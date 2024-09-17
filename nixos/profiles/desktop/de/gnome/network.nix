{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  #imports = [ ./rygel.nix ];
  networking.networkmanager.enable = lib.mkDefault true;
  users.users.${user}.extraGroups = [ "netdev" ] ++ lib.optionals config.networking.networkmanager.enable [
    "networkmanager"
    "nm-openconnect"
  ];
  services.gnome = {
    glib-networking.enable = true; # GLib network extensions
    gnome-online-accounts.enable = true; # Daemon providing single-sign-on framework for GNOME desktop.
    # gnome-online-miners.enable = with config.services.gnome; gnome-online-accounts.enable && tracker-miners.enable; # Index content from remote account services
    gnome-remote-desktop.enable = true; # Remote Desktop
    gnome-user-share.enable = true; # User-level file-sharing service for GNOME.
  };
}
