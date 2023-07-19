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


  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh"; # Relative to $HOME. #dotDir = "${config.xdg.configHome}/zsh"; #config.home.sessionVariables.ZDOTDIR;

    # --- Keybindings ---
    # TODO: Create global user/system-wide keymap setting & set these options correspondingly
    defaultKeymap = "viins";
    prezto.editor.keymap = "vi";

    # --- Directories ---
    # TODO: Use XDG User Dirs if graphical environment (only?)
    # TODO: Use lib to turn dirHashes attrset into equivalent list
    #cdpath = lib. config.programs.zsh.dirHashes
    autocd = true;             # Auto-cd into directory if command name matches dir & not a command
    dirHashes = with config.xdg; {
      # --- Base Dirs ---
      cache  = cacheHome;  #XDG_CACHE_HOME";
      config = configHome; #XDG_CONFIG_HOME";
      data   = dataHome;   #XDG_DATA_HOME";
      state  = stateHome;  #XDG_STATE_HOME";

      # --- User Dirs ---
      desk = userDirs.desktop;
      dl   = userDirs.download;
      docs = userDirs.documents;
      music= userDirs.music;
      pics = userDirs.pictures;
      pub  = userDirs.publicShare;
      templ= userDirs.templates;
      vids = userDirs.videos;

      # --- Extra User Dirs ---
      audio  = userDirs.extraConfig.XDG_AUDIO_DIR;
      back   = userDirs.extraConfig.XDG_BACKUP_DIR;
      book   = userDirs.extraConfig.XDG_BOOKS_DIR;
      code   = userDirs.extraConfig.XDG_CODE_DIR;
      game   = userDirs.extraConfig.XDG_GAMES_DIR;
      note   = userDirs.extraConfig.XDG_NOTES_DIR;
      script = userDirs.extraConfig.XDG_SCRIPTS_DIR;
      vault  = "${config.home.homeDirectory}/Vaults"; #vault= userDirs.extraConfig.XDG_VAULT_DIR;

      # --- Configs ---
      nix    = "${configHome}/nixos"; #XDG_CONFIG_HOME/nixos";

      # --- Keys & Secrets ---
      gpg    = "${config.programs.gpg.homedir}"; #"${config.xdg.dataHome}/gnupg";   #GNUPGHOME";
      ssh    = "${config.home.homeDirectory}/.ssh";       #HOME/.ssh";
      pki    = "${config.home.homeDirectory}/.pki";       #HOME/.pki";
      shh    = "${config.home.homeDirectory}/.local/secrets"; #HOME/.local/secrets";

      # --- Executables ---
      bin    = "${config.home.homeDirectory}/.local/bin"; #HOME/.local/bin";
      repos  = "${config.home.homeDirectory}/.local/repos"; #HOME/.local/repos";
      flatpak= "${config.home.homeDirectory}/.var/app";
    };

    # --- Completion ---
    enableCompletion = true;
    prezto.editor.dotExpansion = true; # Auto expand ... to ../..

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
      autoTitle = true;                      # Issue w/ Blackbox terminal or all iTerm-based?
      #multiplexerTitleFormat = "%s";        # TODO: Test tmux
               tabTitleFormat = "%m: %s";    # TODO: Fix tab titles missing
            windowTitleFormat = "%n@%m: %s"; # TODO: Only user@host if remote host or other user
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

    # TODO: Separate personal keys from profile-related config.
    # TODO: mkSshIdentities = name: [ "id_${name}_rsa" "id_${name}_ed25519" ];
    prezto.ssh.identities = [
      "id_rsa"
      "id_ed25519"
      "id_lehmanator_ed25519"
      "id_slehman_ed25519"
      "id_slehman_rsa"
    ];
  };

  home.sessionVariables.ZDOTDIR = "${config.home.homeDirectory}/${config.programs.zsh.dotDir}";

}
