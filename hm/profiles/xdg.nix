{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}:
# TODO: Only define directories here & prevent pollution of $HOME
# TODO: Set program data dirs, etc. in their own Nix configs if they respect XDG Base Directories spec.
# TODO: Split into directory w/ {default,mime,basedirs,userDirs,paths,etc}.nix  ???
#   xdg/
#     default.nix
#     force.nix
#     mimetypes.nix
#     userdirs.nix
let
  homedir = config.home.homeDirectory;
in {
  xdg.enable = true;

  # --- Base Dirs ---
  xdg.cacheHome = "${homedir}/.cache";
  xdg.configHome = "${homedir}/.config";
  xdg.dataHome = "${homedir}/.local/share";
  xdg.stateHome = "${homedir}/.local/state";

  # --- MIME Type Handling ---
  # TODO: Move to separate file: mimetypes.nix
  # TODO: Set MimeType for default terminal application: `x-scheme-handler/terminal`
  # TODO: Configure: `~/.config/handlr/handlr.toml`
  #xdg.mimeApps = { associations = { added={}; removed={}; }; defaultApplications={}; };
  #home.packages = [pkgs.handlr];
  xdg.mimeApps.enable = true;
  xdg.mime.enable = true;

  xdg.portal = {
    # TODO: Handle other desktop environments with standalone config
    enable = osConfig.services.xserver.enable or config.programs.gnome-shell.enable or false;
    xdgOpenUsePortal = true;
    config = lib.recursiveUpdate (osConfig.xdg.portal.config or {}) {};
    configPackages = (osConfig.xdg.portal.configPackages or []) ++ [];
    extraPortals = (osConfig.xdg.portal.extraPortals or []) ++ [];
  };

  xdg.systemDirs = {
    config = [
      "/etc/xdg"
      config.xdg.configHome
    ];
    data = [
      "/usr/share"
      "/usr/local/share"
      config.xdg.dataHome
    ];
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = with config.xdg; {
      XDG_BACKUP_DIR = "${homedir}/Backup";
      XDG_BOOKS_DIR = "${homedir}/Books";
      XDG_CODE_DIR = "${homedir}/Code";
      XDG_GAMES_DIR = "${homedir}/Games";
      XDG_NOTES_DIR = "${homedir}/Notes";

      XDG_APPS_DIR = "${homedir}/.local/apps";
      XDG_BIN_DIR = "${homedir}/.local/bin";
      XDG_REPOS_DIR = "${homedir}/.local/repos";
      XDG_SCRIPTS_DIR = "${homedir}/.local/scripts";
      XDG_SECRETS_DIR = "${homedir}/.local/secrets";
      XDG_SYNC_DIR = "${homedir}/.local/sync";

      XDG_LAUNCHERS_DIR = "${dataHome}/applications";
      XDG_AUTOSTART_DIR = "${dataHome}/autostart";
      XDG_ICONS_DIR = "${dataHome}/icons";
      XDG_THEMES_DIR = "${dataHome}/themes";
      XDG_UNITS_DIR = "${configHome}/systemd";

      # --- Audio ---
      XDG_AUDIO_DIR = "${homedir}/Audio";
      XDG_AUDIOBOOKS_DIR = "$XDG_AUDIO_DIR/Audiobooks";
      XDG_SOUNDS_DIR = "$XDG_AUDIO_DIR/Sounds";
      XDG_ALARMS_DIR = "$XDG_AUDIO_DIR/Alarms";
      XDG_SOUNDEFFECTS_DIR = "$XDG_AUDIO_DIR/Effects";
      XDG_NOTIFICATIONS_DIR = "$XDG_AUDIO_DIR/Notifications";
      XDG_NOISE_DIR = "$XDG_AUDIO_DIR/Noise";
      XDG_RINGTONES_DIR = "$XDG_AUDIO_DIR/Ringtones";

      # --- Pictures ---
      XDG_CAMERA_PICTURES_DIR = config.xdg.userDirs.pictures + "/Camera";
      XDG_SCREENSHOTS_DIR = config.xdg.userDirs.pictures + "/Screenshots";

      # --- Videos ---
      XDG_CAMERA_RECORDINGS_DIR = config.xdg.userDirs.videos + "/Camera";
      XDG_CLIPS_DIR = config.xdg.userDirs.videos + "/Clips";
      XDG_MOVIES_DIR = config.xdg.userDirs.videos + "/Movies";
      XDG_MUSICVIDEOS_DIR = config.xdg.userDirs.videos + "/Songs";
      XDG_SCREENCASTS_DIR = config.xdg.userDirs.videos + "/Screencasts";
      XDG_TUTORIALS_DIR = config.xdg.userDirs.videos + "/Tutorials";
      XDG_TV_DIR = config.xdg.userDirs.videos + "/TV";
      XDG_YOUTUBE_DIR = config.xdg.userDirs.videos + "/YouTube";
    };
  };

  home.sessionPath = with config.xdg.userDirs.extraConfig; [
    # --- Custom Executables ---
    XDG_APPS_DIR
    XDG_BIN_DIR
    XDG_SCRIPTS_DIR

    # --- Package Managers ---
    config.programs.go.goBin
    # TODO: CARGO_HOME/bin?
    # TODO: NPM bin dir
    # TODO: AppImages?
    # TODO: Script dirs?
    # TODO: Other package managers?

    # --- Editor Executables ---
    #"\${config.xdg.configHome}/emacs/bin"

    # --- Repo Executables ---
    #".git/safe/../../bin"
  ];

  home = {
    # TODO: Package: https://github.com/doron-cohen/antidot
    packages = [pkgs.handlr pkgs.xdg-ninja];
    preferXdgDirectories = true;
    #profileDirectory = "${dataDir}/nix/profiles";
    shellAliases = {
      o = "xdg-open";
      open = "xdg-open";

      cd-config = "cd $XDG_CONFIG_HOME";
      cd-data = "cd $XDG_DATA_HOME";
      cd-cache = "cd $XDG_CACHE_HOME";
      cd-state = "cd $XDG_STATE_HOME";

      ls-config = "ls $XDG_CONFIG_HOME";
      ls-data = "ls $XDG_DATA_HOME";
      ls-cache = "ls $XDG_CACHE_HOME";
      ls-state = "ls $XDG_STATE_HOME";
    };
  };

  # --- XDG Base Dirs: Force respect ---------------------------------
  nix.settings.use-xdg-base-directories = true;

  # --- System -----------------------------------
  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  pam.yubico.authorizedYubiKeys.path = "${config.xdg.dataHome}/yubico/authorized_yubikeys";

  programs = with config.xdg;
  with config.xdg.userDirs.extraConfig; {
    firefox.profiles.default.settings."widget.use-xdg-desktop-portal.file-picker" = 1;

    # --- Programming Languages --------------------
    go = {
      goPath = ".local/go";
      goBin = ".local/bin.go";
      extraGoPaths = ["${dataHome}/go" "${config.home.homeDirectory}/.go"];
    };

    # --- Shells -----------------------------------
    bash.historyFile = "${dataHome}/bash/history";
    zsh.history.path = "${dataHome}/zsh/history";
    nushell = {
      configFile.source = "${configHome}/nushell/config.nu";
      envFile.source = "${configHome}/nushell/env.nu";
    };

    # --- CLI Programs -----------------------------
    gpg.homedir = "${dataHome}/gnupg";
    navi.settings.cheats.paths = ["${dataHome}/cheats" "${configHome}/navi/cheats"];
    script-directory.settings.SD_ROOT = XDG_SCRIPTS_DIR;
    kodi.datadir = "${dataHome}/kodi";
    #kodi = let
    #  inherit (config.xdg) userDirs;
    #  inherit (userDirs) music videos extraConfig;
    #in with extraConfig; {
    #  datadir = "${dataHome}/kodi";
    #  sources = {
    #    video = {
    #      default = "movies";
    #      source = [
    #        { name = "videos"; path=videos;              allowsharing="true"; }
    #        { name = "clips";  path=XDG_CLIPS_DIR;       allowsharing="true"; }
    #        { name = "movies"; path=XDG_MOVIES_DIR;      allowsharing="true"; }
    #        { name = "tv";     path=XDG_TV_DIR;          allowsharing="true"; }
    #        { name = "songs";  path=XDG_MUSICVIDEOS_DIR; allowsharing="true"; }
    #        { name = "shorts"; path=XDG_SHORTS_DIR;      allowsharing="true"; }
    #      ];
    #    };
    #    audio = {
    #      default = "music";
    #      source = [
    #        { name = "music";       path=userdirs.music;      allowsharing="true"; }
    #        { name = "audiobooks";  path=userdirs.music;      allowsharing="true"; }
    #        { name = "musicvideos"; path=XDG_MUSICVIDEOS_DIR; allowsharing="true"; }
    #      ];
    #    };
    #  };
    #};
  };

  # --- GUI Programs -----------------------------
  services = with config.xdg.userDirs.extraConfig;
  with config.xdg; {
    dropbox.path = "${XDG_SYNC_DIR}/dropbox";
    recoll = {
      # File indexer
      configDir = "${configHome}/recoll";
      settings = {
        dbdir = "${dataHome}/recoll";
        mboxcachedir = "${cacheHome}/recoll/mbox";
        webcachedir = "${cacheHome}/recoll/web";
        #iconsdir = "${dataHome}/icons";
        #filtersdir = "${XDG_SCRIPTS_DIR}";
      };
    };
  };
}
