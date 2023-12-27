{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.xddxdd.undetected-chromedriver-bin  # or without -bin to compile manually
  ];
}
