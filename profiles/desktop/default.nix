{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    ./apps/libreoffice.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
}
