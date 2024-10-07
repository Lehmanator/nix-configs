{ inputs
, config, lib, pkgs
, ...
}:
{
  home.packages = [
    # or use pkg without -bin to compile manually
    pkgs.nur.repos.xddxdd.undetected-chromedriver-bin  
  ];
}
