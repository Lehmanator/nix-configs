{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [];

  programs.zsh = {
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

  };
}
