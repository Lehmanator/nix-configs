{ config, lib, pkgs, ... }:
let
  cfg = config.admin;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib) mkDefault mkForce mkIf optional types;
 
in
{
  imports = [];
  options.admin = {
    enable = mkEnableOption "Administrator User";
    username = mkOption {
      type = types.str;
      default = "nixos";
    };
    email = mkOption {
      type = types.strMatching;
      default = cfg.username + "@" + config.networking.domain;
    };
  };

  config = mkIf cfg.enable {
    # Temporary compatibility with existing layout.
    #  Will be removed once profiles adapted to this schema.
    _module.args.user = mkForce cfg.username;

    users.groups.${cfg.username} = {
      gid = mkDefault 1000;
      members = [cfg.username];
    };

    users.users.${cfg.username} = {
      isNormalUser = mkDefault true;
      createHome = mkDefault true;
      autoSubUidGidRange = mkDefault true;
      uid = mkDefault 1000;
      group = mkDefault cfg.username;
      extraGroups = ["wheel" "users" "dialout"]
        ++ optional config.services.openssh.enable "sshd"
        ++ optional config.services.xserver.displayManager.gdm.enable "gdm"
        ++ optional config.networking.networkmanager.enable "NetworkManager"
      ;
    };

    # sops.secrets = {
    #   "user-admin-password-hashed-default" = {};
    #   "user-${cfg.username}-password-hashed" = {
    #     path = inputs.self + /nix/hive/users/${user}/secrets/default.yaml;  
    #   };
    # };

  };
}
