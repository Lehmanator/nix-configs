{ config, lib, pkgs, ... }:
#
# https://github.com/TaKO8Ki/awesome-alternatives-in-rust
# https://gist.github.com/sts10/daadbc2f403bdffad1b6d33aff016c0a
# https://lib.rs/command-line-utilities
#
let
  prefix = false;
  swap-util = gu: ru: {
    home.shellAliases = {
      "${gu}" = lib.getExe pkgs.${ru}; # Unprefixed set to rust version
      "rs-${gu}" = lib.getExe pkgs.${ru}; # Prefixed alias of rust util
      "gnu-${gu}" =
        lib.getExe' pkgs.coreutils-prefixed gu; # Prefixes old coreutil
    };
  };
  util-swap = gu: ru:
    let inherit (lib.attrsets) nameValuePair;
    in [
      (nameValuePair gu (lib.getExe ru))
      (nameValuePair "gnu-${gu}" (lib.getExe' pkgs.coreutils-prefixed gu))
      (nameValuePair "rs-${gu}" (lib.getExe ru))
    ];
in
{
  home = {
    packages = [
      pkgs.dog # DNS client
      pkgs.fselect # SQL-like queries for files.
      pkgs.git-cliff # Changelog generator following Conventional Commit spec
      pkgs.hexyl # Hex viewer
      pkgs.htmlq # jq for HTML
      pkgs.miniserve # Webserver
      pkgs.monolith # Webpage saver to single HTML file
      pkgs.pastel # Gen, analyze, convert, & manip colors
      pkgs.pipr # Interactive pipe viewer
      pkgs.skim # Fuzzy finder
      pkgs.topgrade # Update everything
      pkgs.xh # HTTP request util
      pkgs.xsv # CSV tool
    ] ++ (if prefix then
      [ pkgs.uutils-coreutils ]
    else [
      pkgs.uutils-coreutils-noprefix
      pkgs.coreutils-prefixed
    ])
      #++ lib.optional !prefix pkgs.coreutils-prefixed         # Prefix GNU coreutils if uutils w/ no prefix
      #++ lib.optional !prefix pkgs.uutils-coreutils-noprefix  #  No prefix uutils
      #++ lib.optional  prefix pkgs.uutils-coreutils           # Prefixed uutils
    ;
    shellAliases = with lib.attrsets;
      mapAttrs' (n: v: nameValuePair "rs-${n}" (b v))
        {
          awk = pkgs.frawk;
          bot = pkgs.bottom;
          cp = pkgs.xcp; # cp = uutil "cp" "--progress";
          cut = pkgs.hck;
          df = pkgs.lfs;
          delt = pkgs.delta; # Really nice diff util
          diff = pkgs.difftastic; # Also really nice diff util
          ducttape =
            pkgs.dt; # Duct tape for your unix pipelines # TODO: Make aliases w this
          du = pkgs.du-dust;
          #gnu-du = #pkgs.du-tree;
          dupes = pkgs.fclones; # pkgs.fclones-gui;
          http = pkgs.xh;
          ps = pkgs.procs;
          refact = pkgs.fastmod;
          rm = [ pkgs.rip "--graveyard ${config.xdg.dataHome}/Trash" ];
          rn = pkgs.rnr;
          sed = pkgs.sad; # pkgs.sd;
          sysctl = pkgs.systeroid; # More powerful sysctl tool
          system-info = pkgs.macchina; # Like neofetch but in Rust
          time = pkgs.hyperfine; # Benchmark util
          top = pkgs.bottom;
          uniq = pkgs.huniq;
          watche = pkgs.watchexec;
          xargs = pkgs.rargs;
          #tmux = pkgs.zellij;

          # Count lines of code & show stats
          loc = pkgs.tokei;
        } // {
        # Move in Rust w/ progress bar
        mv = (lib.getExe' pkgs.uutils-coreutils "mv") "--progress";

        # skim - Interactive Grep
        #  https://github.com/lotabout/skim
        # TODO: Move skim to separate config
        rgi = "${lib.getExe pkgs.skim} --ansi -i -c '${
            lib.getExe config.programs.ripgrep.package
          } --color=always --line-number {}'";
      };
  };
}
