{
  config,
  lib,
  pkgs,
  ...
}: {
  # TODO: Split into ./less.nix, ./bat.nix
  imports = [
    #inputs.home-extra-xhmm.homeManagerModules.console.less
  ];

  #programs.less.options = [ #types.str
  #];

  programs = {
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batwatch];
      config = {
        map-syntax = ["*.jenkinsfile:Groovy" "*.props:Java Properties"];
        pager = "less -FR";
        theme = "Monokai Extended Light";
        #theme = "TwoDark";
      };
      themes = {};
    };
    zsh.shellGlobalAliases = {
      BAT = "| bat";
      BCAT = "| bat";
      BDIFF = "| batdiff";
      BGREP = "| batgrep";
      BMAN = "| batman";
      BWATCH = "| batwatch";
    };
  };

  home = {
    sessionVariables.MANPAGER =
      lib.mkIf config.programs.bat.enable "sh -c 'col -bx | bat -l man -p'";
    shellAliases = {
      b = "bat";
      bcat = "bat";
      bdiff = "batdiff";
      bgrep = "batgrep";
      bman = "batman";
      bwatch = "batwatch";
      batfzfpreview =
        lib.mkIf config.programs.fzf.enable
        "bat --color=always --style=numbers --line-range=:5000";
    };
  };
}
