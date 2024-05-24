{ inputs, config, lib, pkgs, ... }: {
  environment.systemPackages = [ pkgs.gnomeExtensions.pano ];
  services.xserver.desktopManager.gnome.sessionPath =
    [ pkgs.gsound pkgs.libgda6 ];
}
