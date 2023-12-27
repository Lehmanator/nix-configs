{ inputs
, config
, lib
, pkgs
, user
, ...
}:
# TODO: Consider scrapping most of this config in favor of home-manager.
#  - NixOS options differ significantly from home-manager
#  - Something is breaking aliases & more.
{
  imports = [ ];

  environment = {
    pathsToLink = [ "/share/zsh" ]; # Enables completion for system packages
    shells = [ pkgs.zsh ]; # Add ZSH to list of available shells
    systemPackages = [ pkgs.zsh ];
  };

  users.defaultUserShell = pkgs.zsh; # ZSH default for users

  programs.zsh = {
    enable = true; # Enable ZSH
    #histFile = with config.xdg; (if enable then dataHome else "${config.home.homeDirectory}/.local/share")+"/zsh/history"; # "$HOME/.local/share/zsh/history";
    #histFile = "${users.users.${user}.home}/.local/share/zsh/history";
    histFile = "$HOME/.local/share/zsh/history";
    histSize = 1000000;

    # --- Completion ------------
    enableCompletion = true; # Enables ZSH completions
    enableBashCompletion = true; # Enables using completions for Bash in ZSH

    # --- Autosuggestions -------
    # - completion     - Based on what tab-completion would choose (req: zpty)
    # - history *      - Most recent history match
    # - match_prev_cmd - Like history, but prefers entry after last cmd
    #autosuggestions = {
    #  enable = true;
    #  strategy = [ "match_prev_cmd" "completion" ]; # Default=["history"]
    #  #async = true;  # Default=true
    #  #extraConfig = {};         # Default={}
    #  #highlightStyle = "fg=8";  # Default="fg=8";
    #};

    # --- Syntax Highlighting ---
    #syntaxHighlighting = {
    #  enable = true;
    #  highlighters = [ # Ordered by priority
    #    "main"         # Base highlighter (Default)
    #    "cursor"       # Matches cursor position
    #    "brackets"     # Matches brackets & paren
    #    "regexp"       # Matches user-defined regular expression
    #    "pattern"      # Matches user-defined glob pattern
    #    "root"         # Matches entire command line if user=root
    #    "line"         # Matches entire command line
    #  ];
    #};

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
