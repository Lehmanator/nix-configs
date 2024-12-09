{ config, lib, pkgs, ... }:
{
  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {
    extraPackages = [pkgs.bash-language-server];
  };

  # --- Neovim ---
  # --- VSCode ---
  # pkgs.vscode-extensions.mads-hartmann.bash-ide-vscode

  # --- Zed ------
  programs.zed-editor.extensions = ["basher"];

  # --- Packages -----------------------------------------------------
  home.packages = [
    # pkgs.bashInteractiveFHS
    pkgs.shellcheck
    pkgs.shellharden
    # pkgs.bash-completion
    pkgs.nix-bash-completions
  ];
}
