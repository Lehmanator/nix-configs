{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.admins;

  mkUserDarwin = n: v: cfg.defaultOptions.darwin // {} // v.options.darwin;
  mkUserHome = n: v:
    cfg.defaultOptions.home-manager // {} // v.options.home-manager;
  mkUserWSL = n: v: cfg.defaultOptions.wsl // {} // v.options.wsl;
  mkUserNixOS = n: v:
    cfg.defaultOptions.nixos
    // {
      name = n;
      description = "Admin: ${n}";
      uid = lib.mkIf v.primary 1000;
    }
    // v.options.nixos;
  secondaryUsers = lib.attrsets.filterAttrs (n: v: n != cfg.primary) cfg.users;
in {
  options.admins = {
    defaultOptions = {
      darwin = lib.mkOption rec {
        type = lib.types.attrs;
        description = "Default nix-darwin options for a user";
        default = {};
        example = default // {homeDirectory = "/home/other-dir";};
      };
      home-manager = lib.mkOption rec {
        type = lib.types.attrs;
        description = "Default home-manager options for a user";
        default = {};
        example = default // {homeDirectory = "/home/other-dir";};
      };
      nixos = lib.mkOption rec {
        type = lib.types.attrs;
        description = "Default NixOS options for a user: users.users.<name>";
        default = {
          autoSubUidGidRange = true;
          createHome = false;
          group = "users";
          hashedPasswordFile =
            config.sops.secrets.user-default-hashed-password.path;
          isNormalUser = true;
          isSystemUser = false;
          ignoreShellProgramCheck = false;
          linger = true;
          packages = []; # TODO: Add admin tools.
        };
        example = default // {shell = pkgs.zsh;};
      };
    };
    primary = lib.mkOption {
      type = lib.types.string;
      description = "User to be the primary admin of this machine";
      default = null;
      example = "sam";
    };
    users = lib.mkOption {
      default = {};
      description = "List of users to make administrators for this machine.";
      type = lib.types.attrsOf (lib.types.submodule ({
        name,
        primary,
        ...
      }: {
        options = {
          options = {
            darwin = lib.mkOption {
              type = lib.types.attrs;
              description = "nix-darwin options for user";
              default = cfg.defaults.darwin;
              #example = cfg.defaults.darwin // { name = "Guy2"; };
            };
            home-manager = lib.mkOption {
              type = lib.types.attrs;
              description = "home-manager options for user";
              default = cfg.defaults.home-manager;
              #example = cfg.defaults.home-manager // { name = "Guy2"; };
            };
            nixos = lib.mkOption {
              type = lib.types.attrs;
              description = "NixOS options under users.users or users.extraUsers";
              default = cfg.defaults.nixos;
              example = cfg.defaults.nixos // {name = "Guy2";};
            };
            wsl = lib.mkOption {
              type = lib.types.attrs;
              description = "nix-wsl options for user";
              default = cfg.defaults.wsl;
              #example = cfg.defaults.wsl // { name = "Guy2"; };
            };
          };
          ssh_keys = lib.mkOption {
            type = lib.types.listOf lib.types.string;
            description = "Public key of admin.";
            default = [];
            example = [
              "ssh-rsa AAAAB3NzaC1yc2etc/etc/etcjwrsh8e596z6J0l7 example@host"
              "ssh-ed25519 AAAAC3NzaCetcetera/etceteraJZMfk3QPfQ foo@bar"
            ];
          };
        };
      }));
    };
  };
  config = {
    services.openssh = {
      #lib.lists.concatLists (lib.attrsets.mapAttrsToList (n: v: v.ssh_keys) cfg.users);
      authorizedKeysFiles = ["/run/secrets/openssh-authorizedkeys"];
      settings.AllowUsers = lib.attrsets.attrNames cfg.users;
    };
    users = {
      users.${cfg.primary} = mkUserNixOS cfg.users.${cfg.primary};
      extraUsers = lib.attrsets.mapAttrs (n: v: mkUserNixOS n) secondaryUsers;
    };
  };
}
