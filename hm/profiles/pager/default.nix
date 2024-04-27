{ config, lib, pkgs, ... }:
let
  inherit (lib) getExe mapAttrs';
  inherit (lib.cli) toGNUCommandLineShell;
  # https://github.com/sharkdp/bat
  args = rec {
    base = {
      color = "auto";
      style = "plain";
      paging = "auto";
    };
    cli = base // {
      color = "always";
      paging = "auto";
    };
    piped = base // {
      paging = "never"; # no pager
      style = "plain";
    };
    fzfpreview = piped // {
      color = "always"; # Ignore pipe and show colors
      line-range = ":5000"; # Limit max lines for perf reasons
      style = "numbers";
    };
  };
  cmd = builtins.mapAttrs (n: v: "bat " + (toGNUCommandLineShell { } v)) args;
  #aliases = lib.mapAttrs' (n: v: "bat-${n}" v) cmd;
in
{
  # TODO: Split into ./less.nix, ./bat.nix
  imports = [
    #inputs.home-extra-xhmm.homeManagerModules.console.less
  ];

  #programs.less.options = [ #types.str
  #];

  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
        theme = "ansi-improved"; # "Monokai Extended Light"; "TwoDark";

        # Map language syntaxes to filenames
        map-syntax = [
          "*.conf:INI"
          "*.ignore:Git Ignore"
          "*.jenkinsfile:Groovy"
          "*.props:Java Properties"
        ];
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
          file = "ansi-improved.tmTheme";
        };
        #ansi-improved = builtins.readFile ./ansi-improved.tmTheme;
      };
    };
    zsh.shellGlobalAliases = {
      BAT = "| ${cmd.base}";
      BCAT = "| ${cmd.base}";
      BDIFF = "| batdiff";
      BGREP = "| batgrep";
      BLOG = "| ${cmd.base} --language log";
      BMAN = "| batman";
      BWATCH = "| batwatch";
      #"--help" = "--help | ${cmd.base} --language help" # Doesnt work
    };
  };

  home = lib.mkIf config.programs.bat.enable {
    sessionVariables = {
      MANPAGER = "batman";
      #MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      #BATPIPE_VIEWERS = "";
      #BATPIPE_ENABLE_COLOR = "true";
      #BATPIPE_INSIDE_LESS = "true";
    };
    shellAliases = rec {
      #aliases // rec {
      bat-cat = cmd.base;
      b = bat-cat;
      bcat = bat-cat;
      cab = bat-cat;

      bat-diff = "batdiff";
      bdiff = bat-diff;
      difb = bat-diff;

      bat-grep = "batgrep";
      bgrep = bat-grep;
      greb = bat-grep;

      bat-man = "batman";
      bman = bat-man;
      mab = bat-man;

      bat-tail = "tail | ${cmd.base} --language log";
      btail = bat-tail;
      taib = bat-tail;

      bat-watch = "batwatch";
      bwatch = bat-watch;
      watcb = bat-watch;

      bat-help = cmd.base + "--language help";
      bathelp = bat-help;
      bhelp = bat-help;
      belp = "bat --language help --color=always --style=plain";

      bat-fzfpreview = lib.mkIf config.programs.fzf.enable cmd.fzfpreview;
    };
  };
}
