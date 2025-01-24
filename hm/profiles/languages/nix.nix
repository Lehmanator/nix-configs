{
  inputs,
  config,
  lib,
  pkgs,
  osConfig,
  ...
}:
let
  # path = config.xdg.configHome + "/nixos";
  path = "/etc/nixos";
  host = osConfig.networking.hostName or "fw";
in
# https://github.com/snowfallorg/drift - Update Nix Flake package sources
# https://github.com/snowfallorg/thaw  - SemVer Nix Flake inputs (only works w/ GitHub for now)
{
  # imports = [(inputs.self + /hm/profiles/nixd.nix)];

  home.packages = [
    pkgs.alejandra
    pkgs.nix-diff
    pkgs.nix-init
    pkgs.nixos-generators
    pkgs.nurl
    pkgs.rnix-hashes
    pkgs.nixfmt-rfc-style
  ];

  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {
    extraPackages = [
      pkgs.alejandra
      pkgs.nixd
      pkgs.nil
      pkgs.deadnix
      pkgs.statix
      pkgs.nixfmt-rfc-style
    ];
    languages = {
      language-server = {
        nixd = {
          command = lib.getExe pkgs.nixd;
          args = [
            "--inlay-hints"
            "--semantic-tokens"
          ];
          config = {
            formatting.command = "alejandra";
            nixpkgs.expr = "import (builtins.getFlake \"${path}\").inputs.nixpkgs { }";
            options = {
              nixos.expr = "(builtins.getFlake \"${path}\").nixosConfigurations.${host}.options";
              home-manager.expr = "(builtins.getFlake \"${path}\").homeConfigurations.${config.home.username}@${host}.options";
              flake-parts.expr = "(builtins.getFlake \"${path}\").debug.options";
            };
          };
        };
        nil = {
          command = lib.getExe pkgs.nil;
          args = [ ];
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.alejandra;
          language-servers = [
            "nixd"
            "nil"
          ];
        }
      ];
    };
  };

  # --- Neovim ---
  # --- VSCode ---
  # --- Zed ------
  programs.zed-editor.extensions = [ "nix" ];
}
