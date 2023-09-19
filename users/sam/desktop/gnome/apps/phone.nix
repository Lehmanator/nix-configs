{ self, inputs
, lib, pkgs, config
, ...
}:
{
  imports = [
  ];

  home.packages = [
    #pkgs.gnomeExtensions.gsconnect
    #pkgs.gnomeExtensions.valent
    pkgs.valent
  ];
}
