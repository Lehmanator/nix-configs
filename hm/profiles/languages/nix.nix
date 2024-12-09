{ config, lib, pkgs, ... }:
{
  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {
    extraPackages = [
      pkgs.nil
    ];
    languages = {
      language = [{
        name = "nix";
        auto-format = false;
        # formatter.command = "";
      }];
    };
  };

  # --- Neovim ---
  # --- VSCode ---
  # --- Zed ------
  programs.zed-editor.extensions = ["nix"];
}
