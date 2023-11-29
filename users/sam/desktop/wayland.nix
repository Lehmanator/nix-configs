{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  xdg.configFile =
    let
      flags = ''
        --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebUIDarkMode,AutoDarkMode,WebAppEnableDarkMode,MobileLayoutTheme
        --ozone-platform-hint=wayland
        --enable-raster-side-dark-mode-for-images
        --webview-selective-image-inversion-darkening
      '';
    in
    {
      electron = {
        target = "${config.xdg.configHome}/electron-flags.conf";
        text = flags;
      };
      chromium = {
        target = "${config.xdg.configHome}/chromium-flags.conf";
        text = flags;
      };
    };
}
