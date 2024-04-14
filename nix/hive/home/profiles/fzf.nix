{
  config,
  lib,
  pkgs,
  ...
}:
#let
#  border = true;
#  height = "40%";
#in
{
  programs.fzf = {
    enable = true;

    colors = {
      gutter = "-1";
      bg = "-1";
      #fg = "-1";
      #preview-fg = "-1";
      #preview-bg = "-1";
      #hl = "";
      #info = "";
      #border = "";
      #prompt = "";
      #pointer = "";
      #marker = "";
      #spinner = "";
      #header = "";
      #"bg+" = "";
      #"fg+" = "";

      #  bg = "#1e1e1e";
      #  "bg+" = "#1e1e1e";
      #  fg = "#d4d4d4";
      #  "fg+" = "#d4d4d4";
    };

    #defaultCommand = "fd --type f";
    #defaultOptions = [
    #  "--height ${height}" "--border"
    #  "--preview-window 'up:60%:wrap:cycle:hidden:border-rounded"
    #];

    # Key: ALT-T
    # TODO: Fix ALT-T not working
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = ["--preview 'eza --icons=always --color=always --tree {} | head -200'"];

    # Key: CTRL-T
    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [
      #"-p" # Floating popup window
      "--preview 'bat --color always --style changes {}'"
      #"--preview-window 'up:60%:wrap:cycle:hidden:border-rounded'"
      "--select-1" # Auto-select item when singular result
      "--exit-0" # Auto exit when list empty
    ];

    # Key: CTRL-R
    # TODO: Style fields
    # TODO: Re-order fields
    #historyWidgetCommand = "";
    #historyWidgetOptions = [
    #  "--sort" "--exact"
    #];

    tmux = {
      enableShellIntegration = true;
      shellIntegrationOptions = [
        "-p" # Floating window
        "-w 50%"
        "-h 50%" # ${height}"
        # See: fzf-tmux --help
        #"-d ${height}"
      ];
    };
  };

  # TODO: Conditional on kakoune install
  programs.kakoune.plugins = [pkgs.kakounePlugins.kak-fzf];

  #programs.pet = {
  #  selectcmdPackage = pkgs.fzf;
  #  settings = {
  #  };
  #};

  home = {
    packages = [
      pkgs.sysz # systemd fzf UI  # TODO: Conditionally load for Linux systems
      pkgs.ytfzf # FZF UI to search & watch YouTube videos
      #pkgs.fzf-obc  # Completion script adding FZF over all known bash completion functions
    ];
    # TODO: Move to sysz
    # TODO: Import this file from ./sysz.nix
    shellAliases = {
      sysu = "sysz --user";
      sysuf = "sysz --user --state failed";
      sysua = "sysz --user --state active";
      syss = "sysz --system";
      syssf = "sysz --sys --state failed";
      syssa = "sysz --sys --state active";
    };
  };
}
