{
  config,
  lib,
  pkgs,
  ...
}: {
  # https://github.com/sharkdp/bat
  # TODO: Split into ./less.nix, ./bat.nix
  #imports = [];
  #inputs.home-extra-xhmm.homeManagerModules.console.less

  #programs.less.options = [ #types.str
  #];

  programs = {
    bat = {
      enable = true;
      config = {
        map-syntax = ["*.jenkinsfile:Groovy" "*.props:Java Properties"];
        pager = "less -FR";
        theme = "ansi-improved"; # "Monokai Extended Light"; "TwoDark";
      };
      extraPackages = [
        pkgs.bat-extras.batdiff
        pkgs.bat-extras.batgrep
        pkgs.bat-extras.batman
        pkgs.bat-extras.batpipe
        pkgs.bat-extras.batwatch
        pkgs.bat-extras.prettybat
      ];

      # Note: bat uses sublime syntax for its themes.
      # Note: OneHalfDark & OneHalfLight change gutter foreground color
      themes = {
        ansi-improved = {
          src = ./.;
          file = "bat-theme-ansi-improved.tmTheme";
        };
        #ansi-improved = builtins.readFile ./ansi-improved.tmTheme;
      };
    };
    zsh.shellGlobalAliases = {
      BAT = "| bat";
      BCAT = "| bat";
      BDIFF = "| batdiff";
      BGREP = "| batgrep";
      BLOG = "| bat --paging=never --style=plain --language log";
      BMAN = "| batman";
      BWATCH = "| batwatch";
      #"--help" = "--help | bat --language help --color=always --style=plain"; # Doesnt work
    };
  };

  home = {
    sessionVariables.MANPAGER =
      lib.mkIf config.programs.bat.enable "sh -c 'col -bx | bat -l man -p'";
    shellAliases = {
      b = "bat";
      bcat = "bat";
      cab = "bat";

      bdiff = "batdiff";
      difb = "batdiff";

      bgrep = "batgrep";
      greb = "batgrep";

      bman = "batman";
      mab = "batman";

      btail = "tail | bat --paging=never --style=plain --color=always --language log";
      taib = "tail | bat --paging=never --style=plain --color=always --language log";

      bwatch = "batwatch";
      watcb = "batwatch";

      batfzfpreview =
        lib.mkIf config.programs.fzf.enable
        "bat --color=always --style=numbers --line-range=:5000";

      bathelp = "bat --language help --color=always --style=plain";
      belp = "bat --language help --color=always --style=plain";
    };
  };
}
