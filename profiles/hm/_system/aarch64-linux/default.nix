{ inputs
, config
, lib
, pkgs
, osConfig
, user
, ...
}:
{
  imports = [
    ../../arch/aarch64
    ../../platform/linux
  ];

}
