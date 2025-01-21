{ config, lib, pkgs, ... }:
# https://github.com/snowfallorg/drift - Update Nix Flake package sources
# https://github.com/snowfallorg/thaw  - SemVer Nix Flake inputs (only works w/ GitHub for now)
{
  home.packages = [
    pkgs.nix-diff
    pkgs.nix-init
    pkgs.nixos-generators  
    pkgs.nurl
    pkgs.rnix-hashes
  ];
  
  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {
    extraPackages = [
      pkgs.nixd
      pkgs.nil
      pkgs.deadnix
      pkgs.statix
    ];
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        }
      ];
    };
  };

  # --- Neovim ---
  # --- VSCode ---
  # --- Zed ------
  programs.zed-editor.extensions = [ "nix" ];
}
