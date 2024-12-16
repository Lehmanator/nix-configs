{ config, lib, pkgs, ... }:
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
      pkgs.nil
      pkgs.deadnix
    ];
    languages = {
      language = [
        {
          name = "nix";
          auto-format = false;
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
