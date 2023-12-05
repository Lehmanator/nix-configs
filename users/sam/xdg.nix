{ self, inputs
, config, lib, pkgs
, ...
}:
let
  homedir = config.home.homeDirectory;
in
  # TODO: Only define directories here & prevent pollution of $HOME
  # TODO: Set program data dirs, etc. in their own Nix configs if they respect XDG Base Directories spec.
  # TODO: Split into directory w/ {default,mime,basedirs,userDirs,paths,etc}.nix  ???
{
  imports = [
  ];

  xdg = {
    enable = true;

    # --- Base Dirs ---
     cacheHome = "${homedir}/.cache";
    configHome = "${homedir}/.config";
      dataHome = "${homedir}/.local/share";
     stateHome = "${homedir}/.local/state";

    # --- MIME Type Handling ---
    mime.enable = true;
    mimeApps = {
      enable = true;
      #associations.added = {
      #};
      #associations.removed = {
      #};
      #defaultApplications = {
      #};
    };

    systemDirs.config = [ "/etc/xdg" ];
    systemDirs.data   = [ "/usr/share" "/usr/local/share" ];

    userDirs.enable = true;
    userDirs.createDirectories = true;
    userDirs.extraConfig = with config.xdg; {
      XDG_BACKUP_DIR = "${homedir}/Backup";
      XDG_BOOKS_DIR = "${homedir}/Books";
      XDG_CODE_DIR  = "${homedir}/Code";
      XDG_GAMES_DIR = "${homedir}/Games";
      XDG_NOTES_DIR = "${homedir}/Notes";

      XDG_AUDIO_DIR = "${homedir}/Audio";
      #XDG_AUDIOBOOKS_DIR = "$XDG_AUDIO_DIR/Audiobooks";
      #XDG_SOUNDS_DIR = "$XDG_AUDIO_DIR/Sounds";
      #XDG_ALARMS_DIR = "$XDG_SOUNDS_DIR/Alarms";
      #XDG_SOUNDEFFECTS_DIR = "$XDG_SOUNDS_DIR/Effects";
      #XDG_NOTIFICATIONS_DIR = "$XDG_SOUNDS_DIR/Notifications";
      #XDG_NOISE_DIR = "$XDG_SOUNDS_DIR/Relax";
      #XDG_RINGTONES_DIR = "$XDG_SOUNDS_DIR/Ringtones";

      #XDG_CLIPS_DIR = "${userdirs.videos}/Clips";
      #XDG_MOVIES_DIR = "${userdirs.videos}/Movies";
      #XDG_MUSICVIDEOS_DIR = "${userdirs.videos}/Songs";
      #XDG_TV_DIR = "${userdirs.videos}/TV";
      #XDG_YOUTUBE_DIR = "${userdirs.videos}/YouTube";

      XDG_APPS_DIR      = "${homedir}/.local/apps";
      XDG_BIN_DIR       = "${homedir}/.local/bin";
      XDG_REPOS_DIR     = "${homedir}/.local/repos";
      XDG_SCRIPTS_DIR   = "${homedir}/.local/scripts";
      XDG_SECRETS_DIR   = "${homedir}/.local/secrets";
      XDG_SYNC_DIR      = "${homedir}/.local/sync";

      XDG_ICONS_DIR     = "${dataHome}/icons";
      XDG_THEMES_DIR    = "${dataHome}/themes";

      XDG_LAUNCHERS_DIR = "${dataHome}/applications";
      XDG_AUTOSTART_DIR = "${dataHome}/autostart";

      XDG_UNITS_DIR     = "${configHome}/systemd";
    };
  };

  # --- XDG Base Dirs: Force respect ---------------------------------
  home.sessionPath = with config.xdg.userDirs.extraConfig; [
    # --- Custom Executables ---
    XDG_APPS_DIR
    XDG_BIN_DIR
    XDG_SCRIPTS_DIR

    # --- Package Managers ---
    config.programs.go.goBin
    # TODO: CARGO_HOME/bin?
    # TODO: NPM bin dir
    # TODO: Other package managers?

    # --- Editor Executables ---
    #"\${config.xdg.configHome}/emacs/bin"

    # --- Repo Executables ---
    #".git/safe/../../bin"
  ];

  # --- Nix ---
  # TODO: Check what normally determines default:
  #  - "${home.homeDirectory}/.nix-profile"
  #  - "/etc/profiles/per-user/${home.username}"
  #home.profileDirectory = "${dataDir}/nix/profiles";
  nix.extraOptions = ''
    use-xdg-base-directories = ${if config.xdg.enable then "true" else "false"}
  '';

  # --- System -----------------------------------
  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  pam.yubico.authorizedYubiKeys.path = "${config.xdg.dataHome}/yubico/authorized_yubikeys";

  # --- Programming Languages --------------------
  programs = with config.xdg; with config.xdg.userDirs.extraConfig; {

    #home-manager.path = pkgs.home-manager;
    #home-manager.path = null;  # Default (ordered): $HOME/{.config/nixpkgs, .nixpkgs}/home-manager

    go.goPath = ".local/go";
    go.goBin  = ".local/bin.go";
    go.extraGoPaths = [ "${dataHome}/go" "${config.home.homeDirectory}/.go" ];

  # --- Shells -----------------------------------
    bash.historyFile = "${dataHome}/bash/history";
    zsh.history.path = "${dataHome}/zsh/history";
    nushell = {
      configFile.source = "${configHome}/nushell/config.nu";
      envFile.source    = "${configHome}/nushell/env.nu";
    };


  # --- CLI Programs -----------------------------
    gpg.homedir                       = "${dataHome}/gnupg";
    navi.settings.cheats.paths        = [ "${dataHome}/cheats" "${configHome}/navi/cheats" ];
    script-directory.settings.SD_ROOT = XDG_SCRIPTS_DIR;
    kodi.datadir                      = "${dataHome}/kodi";
    #kodi = {
    #  datadir = "${dataHome}/kodi";
    #  sources = {
    #    video = {
    #      default = "movies";
    #      source = [
    #        { name = "videos"; path=userdirs.videos;     allowsharing="true"; }
    #        { name = "movies"; path=XDG_MOVIES_DIR;      allowsharing="true"; }
    #        { name = "tv";     path=XDG_TV_DIR;          allowsharing="true"; }
    #        { name = "songs";  path=XDG_MUSICVIDEOS_DIR; allowsharing="true"; }
    #        { name = "clips";  path=XDG_CLIPS_DIR;       allowsharing="true"; }
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
  services = with config.xdg.userDirs.extraConfig; with config.xdg; {
    dropbox.path     = "${XDG_SYNC_DIR}/dropbox";
    recoll = {  # File indexer
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


  # --- XDG Utils ----------------------------------------------------
  home.packages = [
    # TODO: Set MimeType for default terminal application: `x-scheme-handler/terminal`
    # TODO: Configure: `~/.config/handlr/handlr.toml`
    pkgs.handlr
    pkgs.xdg-ninja
  ];

}
