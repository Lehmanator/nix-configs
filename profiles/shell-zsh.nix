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

    # --- Suggestions -----------
    # Stategies:
    # - completion     - Based on what tab-completion would choose (req: zpty)
    # - history *      - Most recent history match
    # - match_prev_cmd - Like history, but prefers entry following prev cmd
    autosuggestions.enable = true;
    autosuggestions.strategy = [ "match_prev_cmd" "completion" ];

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
