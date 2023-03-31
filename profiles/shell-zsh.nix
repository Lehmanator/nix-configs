{
  self,
  system,
  userPrimary,
  inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    # TODO: Put generic shell-agnostic settings here
    #./shell.nix
  ];

  programs.zsh = {
    enable = true;

    # --- Completion ------------
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;

    # --- Syntax Highlighting ---
    syntaxHighlighting.enable = true;
    syntaxHighlighting.highlighters = [ "main" "brackets" "cursor" "line" ];

    # --- Terminal --------------
    vteIntegration = true;
  };

  # --- Prompt ----------------
  # Prompt for Bash & ZSH
  programs.starship.enable = true;

  # --- Default ---------------
  # Make ZSH default for all users
  users.defaultUserShell = pkgs.zsh;
}
