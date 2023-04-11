{ self, inputs, lib, pkgs, config,
  repo, host, network,
  ...
}:
{
  imports = [
  ];

  home.packages = [
    #pkgs.gnomeExtensions.gsconnect
    pkgs.valent
  ];
}
