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
    syntaxHighlighting.highlighters = [ 
      # Ordered by priority
      "main"     # Base highlighter (Default)
      "cursor"   # Matches cursor position
      "brackets" # Matches brackets & paren
      "regexp"   # Matches user-defined regular expression
      "pattern"  # Matches user-defined glob pattern
      "root"     # Matches entire command line if user=root
      "line"     # Matches entire command line
    ];

    # --- Terminal --------------
    vteIntegration = true;
  };


  # --- Login -----------------
  # TODO: Put shell-agnostic form in ./shell.nix
  programs.zsh.loginShellInit = ''
    # Show system info on login
    (( $+commands[neofetch] )) && neofetch
  '';

  # --- Prompt ----------------
  # Prompt for Bash & ZSH
  programs.starship.enable = true;

  # --- Default ---------------
  # Make ZSH default for all users
  users.defaultUserShell = pkgs.zsh;
}
