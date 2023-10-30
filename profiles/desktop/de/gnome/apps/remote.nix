{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  services.gnome.gnome-remote-desktop.enable = true;

  environment.systemPackages = [
    #pkgs.gnome-connections
    pkgs.remmina
    pkgs.gnomeExtensions.remmina-search-provider
  ];

  # TODO: Only set if using Wayland & xwayland
  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.mutter.wayland]
    xwayland-grab-access-rules="['Remmina', 'xfreerdp']"
  '';
}
