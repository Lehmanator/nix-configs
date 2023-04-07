{
  self,
  inputs,
  system,
  host, network, repo,
  config, lib, pkgs,
  ...
}:
{
  imports = [];

  xdg.enable = true;

  # --- MIME Type Handling ---
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  #xdg.mimeApps.associations.added = {
  #};
  #xdg.mimeApps.associations.removed = {
  #};
  #xdg.mimeApps.defaultApplications = {
  #};

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.userDirs.extraConfig = {
    XDG_CODE_DIR  = "${config.home.homeDirectory}/Code";
    XDG_GAMES_DIR = "${config.home.homeDirectory}/Games";
    XDG_NOTES_DIR = "${config.home.homeDirectory}/Notes";

    XDG_APPS_DIR = "${config.home.homeDirectory}/.local/apps";
    XDG_BIN_DIR = "${config.home.homeDirectory}/.local/bin";
    XDG_REPOS_DIR = "${config.home.homeDirectory}/.local/repos";
    XDG_SECRETS_DIR = "${config.home.homeDirectory}/.local/secrets";

    XDG_ICONS_DIR = "${config.xdg.dataHome}/icons";
    XDG_THEMES_DIR = "${config.xdg.dataHome}/themes";
  };
}
