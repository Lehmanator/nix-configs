{ self
, inputs
, host
, network
, repo
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    inputs.home-extra-xhmm.homeManagerModules.console.less
  ];

  #programs.less.options = [ #types.str
  #];

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
    config = {
      map-syntax = [
        "*.jenkinsfile:Groovy"
        "*.props:Java Properties"
      ];
      pager = "less -FR";
      theme = "Monokai Extended Light";
      #theme = "TwoDark";
    };
    themes = { };
  };

  home.shellAliases.b = "bat";
  programs.zsh.shellGlobalAliases = {
    BAT = "| bat";
    B = "| bat";
  };
}
