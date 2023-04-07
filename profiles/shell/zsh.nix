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
    # TODO: Move any generic shell-agnostic settings here
    ./common.nix
  ];

  # --- Default ---------------
  programs.zsh.enable = true;         # Enable ZSH
  users.defaultUserShell = pkgs.zsh;  # ZSH default for users

  # --- Integration -----------
  programs.zsh.vteIntegration = true;

  # --- Completion ------------
  programs.zsh.enableCompletion = true;        # Enables ZSH completions
  programs.zsh.enableBashCompletion = true;    # Enables using completions for Bash in ZSH
  environment.pathsToLink = [ "/share/zsh" ];  # Enables completion for system packages

  # --- Autosuggestions -------
  # - completion     - Based on what tab-completion would choose (req: zpty)
  # - history *      - Most recent history match
  # - match_prev_cmd - Like history, but prefers entry after last cmd
  programs.zsh.autosuggestions = {
    enable = true;
    strategy = [ "match_prev_cmd" "completion" ];
  };

  # --- Syntax Highlighting ---
  programs.zsh.syntaxHighlighting = {
    enable = true;
    highlighters = [ 
      # Ordered by priority
      "main"     # Base highlighter (Default)
      "cursor"   # Matches cursor position
      "brackets" # Matches brackets & paren
      "regexp"   # Matches user-defined regular expression
      "pattern"  # Matches user-defined glob pattern
      "root"     # Matches entire command line if user=root
      "line"     # Matches entire command line
    ];
  };

  # --- Prompt ----------------
  programs.starship.enable = true; # Prompt for Bash & ZSH


  # --- Initialization -------------------------------------

  # --- Prompt Init ----------
  programs.zsh.promptInit = ''
  '';

  # --- All Shells -----------
  programs.zsh.shellInit = ''
    # Load nearcolor module if we have 256 color support
    [[ "$COLORTERM" == (24bit|truecolor) || "$terminfo[colors]" -eq '16777216' ]] || zmodload zsh/nearcolor
  '';

  # --- Interactive Shells ---
  programs.zsh.interactiveShellInit = ''
    zmodload zsh/zpty  # Load pseudo-terminal module
  '';

  # --- Login Shells ----------
  # TODO: Put shell-agnostic form in ./shell.nix
  programs.zsh.loginShellInit = ''
    # Show system info on login
    (( $+commands[neofetch] )) && neofetch
  '';

}
