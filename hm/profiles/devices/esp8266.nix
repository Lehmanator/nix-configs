{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ../../../profiles/server/iot/esphome.nix
    #./arch/arm32.nix
    #./arch/arm64.nix
    #./arch/riscv.nix
  ];

}
