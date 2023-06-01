{ self
, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.dig
    pkgs.ksmbd-tools
    pkgs.samba4Full
  ];
}
