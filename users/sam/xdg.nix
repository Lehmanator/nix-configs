{ self
, inputs
, system
, host
, network
, repo
, config
, lib
, pkgs
, ...
}:
let
  homedir = config.home.homeDirectory;

  #cachedir = config.xdg.cacheHome;
  #confdir = config.xdg.configHome;
  #datadir = config.xdg.dataHome;
  #statedir = config.xdg.stateHome;
  #userdirs = config.xdg.userDirs;
  #extradirs = config.xdg.userDirs.extraConfig;

  #xdg.userDirs.extraConfig."XDG_${name}_DIR" = dir;
in
{
  imports = [
  ];

  xdg = {
    enable = true;
    cacheHome = "${homedir}/.cache";
    configHome = "${homedir}/.config";
    dataHome = "${homedir}/.local/share";
    stateHome = "${homedir}/.local/state";

    # --- MIME Type Handling ---
    mime.enable = true;
    mimeApps.enable = true;
    #mimeApps.associations.added = {
    #};
    #mimeApps.associations.removed = {
    #};
    #mimeApps.defaultApplications = {
    #};

    userDirs.enable = true;
    userDirs.createDirectories = true;
    userDirs.extraConfig = {
      XDG_BOOKS_DIR = "${homedir}/Books";
      XDG_CODE_DIR = "${homedir}/Code";
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

      XDG_APPS_DIR = "${homedir}/.local/apps";
      XDG_BIN_DIR = "${homedir}/.local/bin";
      XDG_REPOS_DIR = "${homedir}/.local/repos";
      XDG_SCRIPTS_DIR = "${homedir}/.local/scripts";
      XDG_SECRETS_DIR = "${homedir}/.local/secrets";
      XDG_SYNC_DIR = "${homedir}/.local/sync";

      XDG_ICONS_DIR = "${config.xdg.dataHome}/icons";
      XDG_THEMES_DIR = "${config.xdg.dataHome}/themes";

      XDG_LAUNCHERS_DIR = "${config.xdg.dataHome}/applications";
      XDG_AUTOSTART_DIR = "${config.xdg.dataHome}/autostart";

      XDG_UNITS_DIR = "${config.xdg.configHome}/systemd";
    };
  };

  # --- XDG Base Dirs: Force respect ---------------------------------
  home.sessionPath = [
    config.xdg.userDirs.extraConfig.XDG_APPS_DIR
    config.xdg.userDirs.extraConfig.XDG_BIN_DIR
    config.xdg.userDirs.extraConfig.XDG_SCRIPTS_DIR
    #"\${xdg.configHome}/emacs/bin"
    #".git/safe/../../bin"
  ];

  # --- Nix ---
  # TODO: Check what normally determines default:
  #  - "${home.homeDirectory}/.nix-profile"
  #  - "/etc/profiles/per-user/${home.username}"
  #home.profileDirectory = "${dataDir}/nix/profiles";
  nix.extraOptions = ''
    use-xdg-base-directories = true
  '';

  # --- System -----------------------------------
  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  pam.yubico.authorizedYubiKeys.path = "${config.xdg.dataHome}/yubico/authorized_yubikeys";
  services.dropbox.path = "${config.xdg.userDirs.extraConfig.XDG_SYNC_DIR}/dropbox";
  #programs.home-manager.path = pkgs.home-manager;
  #programs.home-manager.path = null;  # Default (ordered): $HOME/{.config/nixpkgs, .nixpkgs}/home-manager

  # --- Programming Languages --------------------
  programs.go.goPath = ".local/go";

  # --- Shells -----------------------------------
  programs.bash.historyFile = "${config.xdg.dataHome}/bash/history";
  programs.zsh.history.path = "${config.xdg.dataHome}/zsh/history";
  programs.nushell = {
    configFile.source = "${config.xdg.configHome}/nushell/config.nu";
    envFile.source = "${config.xdg.configHome}/nushell/env.nu";
  };


  # --- CLI Programs -----------------------------
  programs.gpg.homedir = "${config.xdg.dataHome}/gnupg";
  programs.script-directory.settings.SD_ROOT = "${config.xdg.userDirs.extraConfig.XDG_SCRIPTS_DIR}";
  programs.navi.settings.cheats.paths = [ "${config.xdg.dataHome}/cheats" "${config.xdg.configHome}/navi/cheats" ];
  programs.kodi.datadir = "${config.xdg.dataHome}/kodi";
  #programs.kodi = {
  #  datadir = "${config.xdg.dataHome}/kodi";
  #  sources = {
  #    video = {
  #      default = "movies";
  #      source = [
  #        { name = "videos"; path="${userdirs.videos}";               allowsharing="true"; }
  #        { name = "movies"; path="${extradirs.XDG_MOVIES_DIR}";      allowsharing="true"; }
  #        { name = "tv";     path="${extradirs.XDG_TV_DIR}";          allowsharing="true"; }
  #        { name = "songs";  path="${extradirs.XDG_MUSICVIDEOS_DIR}"; allowsharing="true"; }
  #        { name = "clips";  path="${extradirs.XDG_CLIPS_DIR}";       allowsharing="true"; }
  #      ];
  #    };
  #    audio = {
  #      default = "music";
  #      source = [
  #        { name = "music";       path="${userdirs.music}";                allowsharing="true"; }
  #        { name = "audiobooks";  path="${userdirs.music}";                allowsharing="true"; }
  #        { name = "musicvideos"; path="${extradirs.XDG_MUSICVIDEOS_DIR}"; allowsharing="true"; }
  #      ];
  #    };
  #  };
  #};

  # --- GUI Programs -----------------------------
  services.recoll.configDir = "${config.xdg.configHome}/recoll";
}
