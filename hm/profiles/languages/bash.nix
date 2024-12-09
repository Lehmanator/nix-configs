{ config, lib, pkgs, ... }:
{
  # --- Editors ------------------------------------------------------
  # --- Helix ---
  programs.helix = {
    extraPackages = [pkgs.bash-language-server];
    languages = {
      language-server = {
        bash-language-server.command = lib.getExe pkgs.bash-language-server;
      };
      language = [{
        name = "bash";
        auto-format = false;
      }];
    };
  };

  # --- Neovim ---
  # --- VSCode ---
  # pkgs.vscode-extensions.mads-hartmann.bash-ide-vscode

  # --- Zed ------
  programs.zed-editor.extensions = [];

  # --- Packages -----------------------------------------------------
  home.packages = [
    # pkgs.bashInteractiveFHS
    pkgs.shellcheck
    pkgs.shellharden
    # pkgs.bash-completion
    pkgs.nix-bash-completions
  ];
}
