{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    ../../../../profiles/server/iot/esphome.nix
  ];

}
