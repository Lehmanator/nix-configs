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
    ../../arch/riscv64
    ../../platform/linux
  ];

}
