{ inputs, self
, config, lib, pkgs
, ...
}:
let
  border = true;
  height = "40%";
in
{
  imports = [
  ];

  programs.fzf = {
    enable = true;

    #colors = {
    #  bg = "#1e1e1e";
    #  "bg+" = "#1e1e1e";
    #  fg = "#d4d4d4";
    #  "fg+" = "#d4d4d4";
    #};

    #defaultCommand = "fd --type f";
    #defaultOptions = [
    #  "--height ${height}" "--border"
    #];

    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -200'"
    ];

    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [
      "--preview 'head {}'"
    ];

    #historyWidgetCommand = "";
    #historyWidgetOptions = [
    #  "--sort" "--exact"
    #];

    tmux = {
      enableShellIntegration = true;
      shellIntegrationOptions = [
        "-d ${height}"
      ];
    };
  };

  programs.kakoune.plugins = [ pkgs.kakounePlugins.kak-fzf ];

  #programs.pet = {
  #  selectcmdPackage = pkgs.fzf;
  #  settings = {
  #  };
  #};

  home.packages = [
    pkgs.sysz  # systemd fzf UI  # TODO: Conditionally load for Linux systems
    pkgs.ytfzf     # FZF UI to search & watch YouTube videos
    #pkgs.fzf-obc  # Completion script adding FZF over all known bash completion functions
  ];
}
