{
  self,
  inputs,
  system,
  hosts, userPrimary,
  config, lib, pkgs,
  ...
}:
let
  zsh-set-tab-title = ''
    autoload -Uz add-zsh-hook
    function xterm_title_precmd() {
      print -Pn -- '\e]2;%n@%m %~\a'
      [[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
    }
    function xterm_title_preexec () {
      print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${"{(q)1}"}\a"
     [[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${"{(q)1}"}\e\\"; }
    }
    if [[ "$TERM" == (Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|wezterm*|tmux*|xterm*) ]]; then
      add-zsh-hook -Uz precmd  xterm_title_precmd
      add-zsh-hook -Uz preexec xterm_title_preexec
    fi
  '';
in
{
  imports = [
    ./common.nix
  ];
  home.sessionVariables.ZDOTDIR = "${config.xdg.configHome}/zsh";  #"${config.home.homeDirectory}/.config/zsh";

  programs.zsh.enable = true;
  programs.zsh.dotDir = config.home.sessionVariables.ZDOTDIR;
  #programs.zsh.dotDir = if config.xdg.enable then "${config.xdg.configHome}/zsh" else "${config.homeDirectory}/.config/zsh";

  # --- Keybindings ---
  programs.zsh.defaultKeymap = "viins";
  programs.zsh.prezto.editor.keymap = "vi";

  # --- Directories ---
  programs.zsh.autocd = true;
  #programs.zsh.cdpath = lib. config.programs.zsh.dirHashes  # TODO: Find lib to turn attrset values into list
  programs.zsh.dirHashes = {
    # TODO: Use XDG User Dirs if graphical environment
    code = "$HOME/Code";
    dl   = "$HOME/Downloads";
    docs = "$HOME/Documents";
    game = "$HOME/Games";
    note = "$HOME/Notes";
    vids = "$HOME/Videos";

    cache  = "$XDG_CACHE_HOME";
    config = "$XDG_CONFIG_HOME";
    data   = "$XDG_DATA_HOME";
    state  = "$XDG_STATE_HOME";

    nix    = "$XDG_CONFIG_HOME/nixos";

    gpg    = "$GNUPGHOME";
    ssh    = "$HOME/.ssh";

    bin    = "$HOME/.local/bin";
    repos  = "$HOME/.local/repos";
    shh    = "$HOME/.local/secrets";
  };
  programs.zsh.prezto.editor.dotExpansion = true;  # Auto expand ... to ../..

  # --- Completion ---
  programs.zsh.enableCompletion = true;

  # --- Colors ---
  programs.zsh.enableSyntaxHighlighting = true;
  programs.zsh.prezto.syntaxHighlighting = {
    highlighters = [
      "main"
      "brackets"
      "pattern"
      "line"
      "cursor"
      "root"
    ];
    pattern = {
      "rm*-rf*" = "fg=white,bold,bg=red";
    };
    styles = {
      builtin = "bg=blue";
      command = "bg=blue";
      function = "bg=blue";
    };
  };

  # --- Integration ---
  programs.zsh.enableVteIntegration = true;
  programs.zsh.prezto.terminal = {
    autoTitle = true;
    #multiplexerTitleFormat = "%s";
    tabTitleFormat = "%m: %s";
    windowTitleFormat = "%n@%m: %s";
  };
  #programs.zsh.prezto.tmux = {
  #  autoStartLocal = true;
  #  autoStartRemote = true;
  #  defaultSessionName = "";
  #  itermIntegration = true;
  #};

  # --- History ---
  programs.zsh.history.extended = true;
  programs.zsh.history.ignorePatterns = [
    "rm -r *"          "rm -rf *"
    "echo * > *key*"   "echo * > *secret*"
    "echo \"*\" > *key*" "echo \"*\" > *secret*"
    "echo '*' > *key*" "echo '*' > *secret*"
    # TODO: LUKS commands w/ key passed in CLI
  ];
  programs.zsh.history.share = true;
  programs.zsh.history.ignoreSpace = true;
  programs.zsh.historySubstringSearch.enable = true;

  # --- Initialization -------------------------------------
  programs.zsh.initExtra = ''
    function cdls() { exa -a --icons --git --group-directories-first }
    chpwd_functions=(cdls)
  '';

  # --- Plugins --------------------------------------------
  programs.zsh.prezto.enable = true;
  programs.zsh.plugins = [
    # Use ZSH inside nix-shell
    { name = "zsh-nix-shell"; file = "nix-shell.plugin.zsh";
      src = pkgs.fetchFromGitHub {
        owner = "chisui"; repo = "zsh-nix-shell"; rev = "v0.5.0";
        sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
      };
    }
  ];

  # ---- Extras --------------------------------------------
  programs.zsh.prezto.extraFunctions = [ "zargs" "zmv"  ];  # Extra ZSH functions to load. See: `$ man zshcontrib`
  programs.zsh.prezto.extraModules   = [ "attr"  "stat" ];  # Extra ZSH modules to load.   See: `$ man zshmodules`
  programs.zsh.prezto.pmodules = [
    "environment"
    "terminal"
    "editor"
    "history"
    "directory"
    "spectrum"
    "utility"
    "completion"
    "prompt"
  ];
  programs.zsh.prezto.ssh.identities = [
    "id_rsa"
    "id_ed25519"
  ];
}
