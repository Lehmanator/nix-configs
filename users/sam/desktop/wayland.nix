{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  xdg.configFile.electron = {
    target = "${config.xdg.configHome}/electron-flags.conf";
    text = ''
      --enable-features=UseOzonePlatform,WaylandWindowDecorations
      --ozone-platform-hint=wayland
    '';
  };
}
