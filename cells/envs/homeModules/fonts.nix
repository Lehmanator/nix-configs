{ self, inputs,
  config, lib, pkgs,
  ...
}: with lib;
let
  cfg = config.services;
in
{

  imports = [
  ];

  options = with types; {
    enable = mkEnableOption "desc";
  };

  config = mkIf cfg.enable {
  };

}
