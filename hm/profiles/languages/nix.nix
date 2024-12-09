{ config, lib, pkgs, ... }:
{
  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {
    languages = {
      language-server = {
        nil.command = "${pkgs.nil}/bin/nil";
      };
      language = [{
        name = "nix";
        auto-format = false;
      }];
    };
  };

  # --- Neovim ---
  # --- VSCode ---
  # --- Zed ------
  programs.zed-editor.extensions = ["nix"];
}
