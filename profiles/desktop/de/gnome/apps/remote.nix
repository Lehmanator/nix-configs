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

  environment.systemPackages = [
    pkgs.remmina
    pkgs.gnomeExtensions.remmina-search-provider
  ];

  # TODO: Only set if using Wayland & xwayland
  services.xserver.desktopManager.gnome.extraGSettings = ''
    [org.gnome.mutter.wayland]
    xwayland-grab-access-rules "['Remmina', 'xfreerdp']"
  '';

}
