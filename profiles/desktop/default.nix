{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [

  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
}
