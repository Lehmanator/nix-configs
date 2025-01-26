{pkgs, ...}: {
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    histFile = "$HOME/.local/share/zsh/history";
    histSize = 1000000;
    enableBashCompletion = true;
    enableCompletion = true;

    # Might be necessary to use completions from home-manager?
    enableGlobalCompInit = false;

    # --- Autosuggestions -------
    # - completion     - Based on what tab-completion would choose (req: zpty)
    # - history *      - Most recent history match
    # - match_prev_cmd - Like history, but prefers entry after last cmd
    autosuggestions = {
      enable = true;
      strategy = ["history" "completion"];
      # strategy = [ "match_prev_cmd" "completion" ]; # Default=["history"]
      # #extraConfig = {};         # Default={}
      # #highlightStyle = "fg=8";  # Default="fg=8";
    };

    # --- Syntax Highlighting ---
    enableLsColors = true;
    syntaxHighlighting = {
      enable = true;
      # Ordered by priority
      highlighters = [
        "main" # Base highlighter (Default)
        "cursor" # Matches cursor position
        "brackets" # Matches brackets & paren
        "regexp" # Matches user-defined regular expression
        "pattern" # Matches user-defined glob pattern
        "root" # Matches entire command line if user=root
        "line" # Matches entire command line
      ];
      patterns = {
        "rm -rf *" = "fg=white,bold,bg=red";
      };
      styles = {
        alias = "fg=magenta,bold";
      };
    };

    # --- Integration -----------
    vteIntegration = true;

    # --- Initialization -------------------------------------
    # --- Prompt Init ----------
    #promptInit = ''
    #'';

    # --- All Shells -----------
    #shellInit = ''
    #  # Load nearcolor module if we have 256 color support
    #  [[ "$COLORTERM" == (24bit|truecolor) || "$terminfo[colors]" -eq '16777216' ]] || zmodload zsh/nearcolor
    #'';

    # --- Interactive Shells ---
    #interactiveShellInit = ''
    #  zmodload zsh/zpty  # Load pseudo-terminal module
    #'';

    # --- Login Shells ----------
    # TODO: Put shell-agnostic form in ./shell.nix
    #loginShellInit = ''
    #'';
  };

  # --- Prompt -------------------------------------------------------
}
