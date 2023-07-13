{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
  ];

  # --- NetworkManager ---
  networking.networkmanager.enable = true;
  users.users."${user}".extraGroups = lib.mkIf config.networking.networkmanager.enable ["netdev" "networkmanager" "nm-openconnect"];

  services.gnome.glib-networking.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gnome.gnome-online-miners.enable = config.services.gnome.gnome-online-accounts.enable && config.services.gnome.tracker-miners.enable;

  # Remote Desktop
  services.gnome.gnome-remote-desktop.enable = true;
  services.gnome.gnome-user-share.enable = true;

}
