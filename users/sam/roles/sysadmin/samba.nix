{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.ksmbd-tools
    pkgs.samba4Full
  ];

}
