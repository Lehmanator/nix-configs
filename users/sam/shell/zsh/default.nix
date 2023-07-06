{ self
, inputs
, system
, hosts
, userPrimary
, config
, lib
, pkgs
, ...
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
    ../common
    ./alias.nix
    ./highlight.nix
    ./history.nix
  ];

  home.sessionVariables.ZDOTDIR = "${config.xdg.configHome}/zsh"; #"${config.home.homeDirectory}/.config/zsh";

  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh"; #config.home.sessionVariables.ZDOTDIR;

    # --- Keybindings ---
    # TODO: Create global user/system-wide keymap setting & set these options correspondingly
    defaultKeymap = "viins";
    prezto.editor.keymap = "vi";

    # --- Directories ---
    # TODO: Use XDG User Dirs if graphical environment
    autocd = true;             # Auto-cd into directory if command name matches dir & not a command
    #cdpath = lib. config.programs.zsh.dirHashes  # TODO: Find lib to turn attrset values into list
    dirHashes = {
      code = "$HOME/Code";
      dl = "$HOME/Downloads";
      docs = "$HOME/Documents";
      game = "$HOME/Games";
      note = "$HOME/Notes";
      vids = "$HOME/Videos";

      cache = "$XDG_CACHE_HOME";
      config = "$XDG_CONFIG_HOME";
      data = "$XDG_DATA_HOME";
      state = "$XDG_STATE_HOME";

      nix = "$XDG_CONFIG_HOME/nixos";

      gpg = "$GNUPGHOME";
      ssh = "$HOME/.ssh";

      bin = "$HOME/.local/bin";
      repos = "$HOME/.local/repos";
      shh = "$HOME/.local/secrets";
    };
    prezto.editor.dotExpansion = true; # Auto expand ... to ../..

    # --- Completion ---
    enableCompletion = true;

    # --- Initialization -------------------------------------
    # TODO: Move cdls to user zsh config
    #initExtra = ''
    #  function cdls() {
    #    ${pkgs.exa}/bin/exa -a --icons --git --group-directories-first
    #  }
    #  chpwd_functions=(cdls)
    #'';
    #initExtraBeforeCompInit
    #initExtraFirst
    #localVariables
    #loginExtra
    #logoutExtra

    # --- Integration ---
    enableVteIntegration = true;
    prezto.terminal = {
      autoTitle = true;
      #multiplexerTitleFormat = "%s";
      tabTitleFormat = "%m: %s";
      windowTitleFormat = "%n@%m: %s";
    };
    #prezto.tmux = {
    #  autoStartLocal = true;
    #  autoStartRemote = true;
    #  defaultSessionName = "";
    #  itermIntegration = true;
    #};

    # --- Plugins --------------------------------------------
    # TODO: Fetch plugins using nvfetcher & nixpkgs overlay ?
    prezto.enable = true;
    plugins = [
      { name = "zsh-nix-shell"; file = "nix-shell.plugin.zsh";   # Use ZSH inside nix-shell
        src = pkgs.fetchFromGitHub { owner = "chisui"; repo = "zsh-nix-shell"; rev = "v0.7.0"; hash = "sha256-oQpYKBt0gmOSBgay2HgbXiDoZo5FoUKwyHSlUrOAP5E="; };
      }
    ];

    # ---- Extras --------------------------------------------
    prezto.extraFunctions = [ "zargs" "zmv" ]; # Extra ZSH functions to load. See: `$ man zshcontrib`
    prezto.extraModules = [ "attr" "stat" ]; # Extra ZSH modules to load.   See: `$ man zshmodules`
    prezto.pmodules = [
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
    prezto.ssh.identities = [
      "id_rsa"
      "id_ed25519"
      "id_lehmanator_ed25519"
    ];
  };
}
