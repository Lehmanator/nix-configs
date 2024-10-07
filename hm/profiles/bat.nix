{ config, lib, pkgs, ... }: 
#
# https://github.com/sharkdp/bat
#
# TODO: Configure lesspipe.sh
# TODO: Nushell shellAliases
# TODO: Zsh abbr abbreviations
#
# TODO: Figure out how to use separate flags for:
#       - fuzzy util previewer    (--style=full,-grid)
#       - interactive shell calls (--style=changes,grid , when normal cat)
#       - shell pipelines         (--style=plain  , when piped to cmd)
#       - paged/non-paged output  (--style=full   , when using pager)
#
# TODO: Preview command for ripgrep output
# TODO: Auto light/dark mode depending on desktop environment
#       - GNOME: gsettings get org.gnome.desktop.interface color-scheme -> 'prefer-dark'
#
# TODO: https://github.com/termstandard/colors
#       - sshd_config: AcceptEnv COLORTERM
#       - ssh_config:    SendEnv COLORTERM
#       - /etc/sudoers: env_keep COLORTERM
#
{
  programs.bat = {
    enable = true;

    # extraPackages = with pkgs.bat-extras; [batdiff batgrep batman batpipe batwatch prettybat];
    extraPackages = builtins.attrValues (lib.filterAttrs (_: v: builtins.isAttrs v) pkgs.bat-extras);

    # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.bat.syntaxes
    # syntaxes = {};
    
    config = {
      pager       = "less -FR"; # less command to use for paging
      theme       = "base16";   # "ansi-improved"
      color       = "auto";     # always | never | auto
      decorations = "auto";     # always | never | auto
      italic-text = "always";   # always | never
      paging      = "auto" ;    # always | never | auto
      wrap        = "auto";     # always | never | auto
      style       = "auto";     # Comma-separated list of: (w/ + or -)
                                #   default, full, auto, plain, changes,
                                #    header, header-filename, header-filesize,
                                #   changes, grid, rule, numbers, snip
      diff-context   = "10";    # Show N lines above/below when called w/ --diff
      ignored-suffix = ".old";  # TODO: Use home-manager backup extension
      tabs = "2";

      map-syntax = ["*.jenkinsfile:Groovy" "*.props:Java Properties"];
    };

    # TODO: Use lib.fileset to pickup theme files.
    # NOTE: bat uses sublime syntax for its themes.
    # NOTE: OneHalfDark & OneHalfLight change gutter foreground color
    # NOTE: ansi-improved theme makes dividers & line numbers dimmer
    # NOTE: https://github.com/chriskempson/base16/blob/main/styling.md
    # NOTE: https://github.com/chriskempson/base16-shell
    # NOTE: https://github.com/termstandard/colors
    # themes.ansi-improved = { src = ./.; file = "bat-ansi-improved.tmTheme"; };

  };

  programs.zsh.shellGlobalAliases = {
    BAT    = "| bat";      # TODO: set previous cmd stdin as title
    BCAT   = "| bat";
    BDIFF  = "| batdiff";
    BGREP  = "| batgrep";
    BLOG   = "| bat --paging=never --style=plain --language log";
    BMAN   = "| batman";
    BWATCH = "| batwatch";
    #"--help" = "--help | bat --language help --color=always --style=plain"; # Doesnt work
    "-h"     =     "-h 2>&1 | bat --language=help --style=plain";
    "--help" = "--help 2>&1 | bat --language=help --style=plain";
  };

  home = {
    sessionVariables = {

      # Use bat as pager for manpages
      # NOTE: Doesnt work with Mandocs `man` impl
      MANPAGER   = lib.mkIf config.programs.bat.enable
        "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = lib.mkIf config.programs.bat.enable
        "-c";  # Fixes formatting

      # PAGER     = "";
      # LESS      = "";
      # LESSOPEN  = "";
      # BAT_PAGER = "";
      # BAT_STYLE = "";
      # BAT_THEME = "";
    };

    # TODO: Theme previewer (w/ file) = "bat --list-themes | fzf --preview='bat --theme={} --color=always flake.nix'";
    shellAliases = 
    # let
    #   getBaseCmd = c: lib.removePrefix "bat" (lib.removeSuffix "bat" c); 
    #   batAliases = lib.concatMapAttrs (n: v: 
    #   let
    #     base = getBaseCmd n;
    #     pre = "b" + builtins.substring 1 99 base;
    #     suf = builtins.
    #     cmd = n;
    #     # cmd = lib.getExe v + " " + lib.concatStringsSep " " args;
    #   in rec {
    #     "${base}" = cmd;
    #     "b${base}" = cmd;
    #     "${base}b" = cmd;
    #   }) config.programs.bat.extraPackages;

    #   mkBatAliases = cmd: aliases: let
    #     # args = builtins.tail (lib.splitString " " cmd);
    #     # alias = builtins.concatStringsSep " " [(lib.getExe pkgs.bat-extras.${prog})] ++ (builtins.tail (lib.splitString " " cmd));
    #     # args = builtins.concatStringsSep " " builtins.tail (lib.splitString " " [lib.getExe pkgs.bat-extras.${prog}] ++ cmd);
    #     # alias = lib.getExe pkgs.bat-extras.${prog} + 
    #     prog = builtins.head (lib.splitString " " cmd);
    #   in lib.optionalAttrs
    #     # Alias creation condition: pname in bat.extraPackages
    #     (builtins.elem config.programs.bat.extraPackages pkgs.bat-extras.${prog})

    #     # Create attr for each alias set to executable of ${prog}
    #     (lib.genAttrs aliases (_:                      # forAll {<alias..>=cmd}
    #       builtins.concatStringsSep " "                # Assemble command
    #         [(lib.getExe pkgs.bat-extras.${prog})] ++  # Prefix command w/ bin
    #           builtins.tail (lib.splitString " " cmd)  # Reconnect args string
    #     ))
    #   ;
    #   mkBatExtra = util: mkBatAliases ["b${util}" "${util}b" "${builtins.substring 0 3 util}b"];
    #   # batExtras = lib.concatMapAttrs
    #   batExtras = args: lib.concatMapAttrs (pname: v:
    #   let
    #     prog = builtins.substring 3 99 pname;
    #     cmd  = builtins.concatStringsSep " " ([(lib.getExe v)]) ++ args;
    #   in {
    #     "b${prog}"  = cmd;
    #      "${prog}b" = cmd;
    #      "${builtins.substring 0 3 prog}b" = cmd;
    #   }) config.programs.bat.extraPackages;
    # in 
    # (mkBatAliases "bat"      ["bcat"  "catb"  "cab" "b"])
    # (mkBatAliases "batdiff"  ["bdiff" "diffb" "difb"])
    # (mkBatAliases "batgrep"  ["bgrep" "grepb" "greb"])
    # (mkBatAliases "batman"   ["bman"  "manb"  "mab" ])
    # (mkBatAliases "batwatch" ["bman"  "manb"  "mab" ])

    rec {
      bcat ="bat";      catb="bat";      cab="bat";     b="bat";
    };
    #   bdiff="batdiff"; diffb="batdiff"; difb="batdiff"; d="batdiff";
    #   bgrep="batgrep"; grepb="batgrep"; greb="batgrep"; #rg="batgrep";
    #   bman ="batman";   manb="batman";   mab="batman";  m="batman";

    #   btail = "tail | bat --paging=never --style=plain --color=always --language log"; tailb=btail; taib=btail;

    #   watch="batwatch"; bwatch=watch; watchb=watch; watcb=watch;
    #   cat="bat"; bcat="bat"; catb="bat"; cab="cat"; b="bat"; 

    #   # TODO: lib.getFuzzyPreviewer "text"
    #   batfzfpreview = lib.mkIf config.programs.fzf.enable
    #     "bat --color=always --style=numbers --line-range=:5000";

    #   bathelp = "bat --language help --color=always --style=plain";
    #   belp    = "bat --language help --color=always --style=plain";
    # } // lib.optionalAttrs (builtins.elem config.programs.bat.extraPackages pkgs.batdiff) ;
  };
}
