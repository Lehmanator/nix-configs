{ config, lib, pkgs, ... }:
let
  cfg = config.admin;
in
{
  imports = [];

  options.admin = {
    enable = lib.mkEnableOption "Administrator User";
    username = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
    };
    email = lib.mkOption {
      type = lib.types.strMatching;
      default = cfg.username + "@" + config.networking.domain;
    };
  };

  config = lib.mkIf cfg.enable {
    # Temporary compatibility with existing layout.
    #  Will be removed once profiles adapted to this schema.
    _module.args.user = lib.mkForce cfg.username;
    users.users.${cfg.username}.extraGroups = ["wheel" "users" "sshd"];
  };
}
