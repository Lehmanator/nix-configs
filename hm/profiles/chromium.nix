{ inputs, config, lib, pkgs, ... }:
{
  imports = [];

  programs.chromium = {
    enable = true;
  };

  services.flatpak.packages = [
    "com.github.Eloston.UngoogledChromium"
    "com.github.Eloston.UngoogledChromium.Codecs"
  ];

  home.packages = [
    pkgs.chromium
    # pkgs.chromiumBeta
    # pkgs.chromiumDev
    # pkgs.ungoogled-chromium
  ];

}
