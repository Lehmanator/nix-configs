{ inputs
, config
, lib
, pkgs
, osConfig
, user
, ...
}:
{
  programs.chromium = {
    enable = true;
  };

  home.packages = [
    #pkgs.ungoogled-chromium
    pkgs.chromium
    #pkgs.chromiumBeta
    #pkgs.chromiumDev
  ];

}
