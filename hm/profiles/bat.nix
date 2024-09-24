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

    extraPackages = with pkgs.bat-extras; [batdiff batgrep batman batpipe batwatch prettybat];

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
    BAT    = "| bat";
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
      MANPAGER  = lib.mkIf config.programs.bat.enable "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT= lib.mkIf config.programs.bat.enable "-c";  # Fixes formatting

      # PAGER     = "";
      # LESS      = "";
      # LESSOPEN  = "";
      # BAT_PAGER = "";
      # BAT_STYLE = "";
      # BAT_THEME = "";
    };

    # TODO: Theme previewer (w/ file) = "bat --list-themes | fzf --preview='bat --theme={} --color=always flake.nix'";
    shellAliases = {
      b    = "bat";
      bcat = "bat";
      cab  = "bat";

      bdiff = "batdiff";
      difb  = "batdiff";

      bgrep = "batgrep";
      greb  = "batgrep";

      bman  = "batman";
      mab   = "batman";

      btail = "tail | bat --paging=never --style=plain --color=always --language log";
      taib  = "tail | bat --paging=never --style=plain --color=always --language log";

      bwatch = "batwatch";
      watcb  = "batwatch";

      # TODO: lib.getFuzzyPreviewer "text"
      batfzfpreview = lib.mkIf config.programs.fzf.enable
        "bat --color=always --style=numbers --line-range=:5000";

      bathelp = "bat --language help --color=always --style=plain";
      belp    = "bat --language help --color=always --style=plain";
    };
  };
}
