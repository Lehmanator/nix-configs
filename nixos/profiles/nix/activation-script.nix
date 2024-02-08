{
  config,
  lib,
  pkgs,
  ...
}: let
  # ╭────────────────────────────────────────────────────────────────╮
  # │ Constants                                                      │
  # ╰────────────────────────────────────────────────────────────────╯
  padding = {
    terminal = {
      left = 0;
      right = 20;
      center = 10;
    };
    box = {
      top = 0;
      bot = 0;
      left = 1;
      right = 1;
    };
  };
  # https://gist.github.com/nico/befa4300d44ffe579553d37ae0981941
  # https://github.com/dylanaraps/writing-a-tui-in-bash
  chars = {
    horz = "─";
    vert = "│";
    top-left = "╭";
    top-right = "╮";
    bot-left = "╰";
    bot-right = "╯";

    prefix = {
      warn = "";
      info = "";
      alert = "！";
      note = "⁕";
      star-yellow = "⭐";
      star-filled = "⭑";
      star-stroke = "⭒";
      sparkle = "✨";
    };
    box = {
      thick = {
        h = "┃";
        v = "━";
        tr = "┓";
      };
    };
  };
  cols = "$(${pkgs.ncurses}/bin/tput cols)";
  seq = "${pkgs.coreutils}/bin/seq";

  # ╭────────────────────────────────────────────────────────────────╮
  # │ Helper Functions                                               │
  # ╰────────────────────────────────────────────────────────────────╯
  #   ┌──┬──┐  ╭──┬──╮  ┏━━┳━━┓  ╔══╦══╗
  #   │     │  │     │  ┃     ┃  ║  ‖  ║
  #   ├  ┼  ┤  ├  ┼  ┤  ┣  ╋  ┫  ╠  ╬  ╣
  #   │     │  │     │  ┃     ┃  ║     ║
  #   └──┴──┘  ╰──┴──╯  ┗━━┻━━┛  ╚══╩══╝
  #    ──────
  #   ╱─┬──┐  ╭──┬──╮  ┏━━┳━━┓  ╔══╦══╗
  #   │     │  │     │  ┃     ┃  ║     ║
  #   ├  ┼  ┤  ├  ┼  ┤  ┣  ╋  ┫  ╠  ╬  ╣
  #   │     │  │     │  ┃     ┃  ║     ║
  #   └──┴──┘  ╰──┴──╯  ┗━━┻━━┛  ╚══╩══╝
  # ⸀⸍────────────────────────────────────────────────────────────────⸜
  # │ Helper Functions                                               │
  # ╰────────────────────────────────────────────────────────────────╯⸜
  #   Brackets:〖 〗,〘 〙, 〚 〛,
  # Horizontal: 〜,
  #   Vertical: ＿＿, __, --, ⸺⸺, ⸻⸻,
  #   Vertical: ⸽, ⸾,
  strlen = s: lib.lists.count (x: true) (lib.strings.stringToCharacters s);

  #mkTopFixed = text: { margin ? 1
  #                   , padding ? 1
  #                   , size ? 50
  #                   ,
  #                   }:
  #  mkLineFixed (mkTitle text { }) {
  #    inherit margin padding size;
  #    char-left = chars.top-left;
  #    char-right = chars.top-right;
  #    char-fill = chars.horz;
  #  };
  #mkMidFixed = text: { margin ? 1
  #                   , padding ? 1
  #                   , size ? 50
  #                   ,
  #                   }:
  #  mkLineFixed text {
  #    inherit margin padding size;
  #    char-left = chars.vert;
  #    char-right = chars.vert;
  #    char-fill = " ";
  #  };
  #mkBotFixed =
  #  { margin ? 1
  #  , padding ? 1
  #  , size ? 50
  #  ,
  #  }:
  #  mkLineFixed "" {
  #    inherit margin padding size;
  #    char-left = chars.bot-left;
  #    char-right = chars.bot-right;
  #    char-full = chars.horz;
  #  };
  #
  #mkTopFixed = {
  #  title ? {}, # position="center"; },
  #  style ? "round",
  #  margin ? 1,
  #  size ? 50,
  #}: let
  #  fmt-title = mkTitle {text = title;};
  #  rem-chars = (size - 2) - (strlen fmt-title);
  #  suffix =
  #    lib.strings.fixedWidthString rem-chars chars.horz chars.top-right;
  #in
  #  chars.top-left + chars.horz + fmt-title + suffix;

  #mkMidFixed = {
  #  line ? "",
  #  style ? "round",
  #  margin ? 1,
  #  padding ? 1,
  #  size ? 50,
  #}: with lib.strings; let
  #  l = fixedWidthString (margin + 1) " " chars.vert;
  #  text = fixedWidthString ((strlen line) + padding) " " line;
  #  r =
  #    lib.strings.fixedWidthString (size - ((strlen text) + 1)) " "
  #    chars.vert;
  #in
  #  l + text + r;

  #mkBotFixed = {
  #  style ? "round",
  #  margin ? 1,
  #  size ? 50,
  #}: let
  #  l = lib.strings.fixedWidthString (margin + 1) " " chars.bot-left;
  #  suffix =
  #    lib.strings.fixedWidthString (size - 1) chars.horz chars.bot-right;
  #in
  #  l + suffix;

  mkBoxFixed = {
    title ? "",
    title-sep ? "square",
    title-sep-space-inner ? false,
    title-sep-space-outer ? false,
    contents ? "",
    padding ? 1,
    margin ? 1,
    size ? 60,
    style ? "round",
  }: let
    caps = {
      curly.l = "{";
      curly.r = "}";
      square.l = "[";
      square.r = "]";
      round.l = "(";
      round.r = ")";
      angle.l = "<";
      angle.r = ">";
      plus.l = "+";
      plus.r = "+";
      double-vert.l = "꡷";
      double-vert.r = "꡷";
      double-round.l = "｟";
      double-round.r = "｠";
      half-square.l = "｢";
      half-square.r = "｣";
      none.l = "";
      none.r = "";
      vert.l = chars.vert;
      vert.r = chars.vert;
    };
    #    echo '  ───Nix─Path─────────────────────────────────────────────────  │'
    #    echo "$NIX_PATH" | tr ':' '\n' | tr '=' ' ' | column --table --output-separator ' │ ' --output-width 60 --table-column name=Input,width=20,right,trunc --table-column name=Path,wrap
    #    echo '│  ───────────────────────────────────────────────────────────  │'
    bchar =
      {
        round.top = {
          l = "╭";
          m = "─";
          r = "╮";
        };
        round.mid = {
          l = "│";
          m = " ";
          r = "│";
        };
        round.bot = {
          l = "╰";
          m = "─";
          r = "╯";
        };
        square.top = {
          l = "┌";
          m = "─";
          r = "┐";
        };
        square.mid = {
          l = "│";
          m = " ";
          r = "│";
        };
        square.bot = {
          l = "└";
          m = "─";
          r = "┘";
        };
        double.top = {
          l = "╔";
          m = "═";
          r = "╗";
        };
        double.mid = {
          l = "║";
          m = " ";
          r = "║";
        };
        double.bot = {
          l = "╚";
          m = "═";
          r = "╝";
        };
        thick.top = {
          l = "┏";
          m = "━";
          r = "┓";
        };
        thick.mid = {
          l = "┃";
          m = " ";
          r = "┃";
        };
        thick.bot = {
          l = "┗";
          m = "━";
          r = "┛";
        };
      }
      .${style};

    sep =
      if (strlen title-sep) < 4
      then {
        l = title-sep;
        r = title-sep;
      }
      else caps.${title-sep};
    fmt-title = with lib.strings;
      (optionalString title-sep-space-outer " ")
      + sep.l
      + (optionalString title-sep-space-inner " ")
      + title
      + (optionalString title-sep-space-inner " ")
      + sep.r
      + (optionalString title-sep-space-outer " ");

    mkLineFixed = {
      text ? "",
      char ? bchar.mid,
    }: let
      #{l ? bchar.${style}.mid.r, r ? bchar.${style}.mid.r, m ? bchar.${style}.mid.m}:
      until = rec {
        lborder = margin + 1;
        lpadding = lborder + 1;
        ltext = lpadding + padding;
        rpadding = ltext + (strlen text);
        rborder = rpadding + padding;
        rmargin = rborder + 1;
      };
      lens = {
        lmargin-lborder = margin + (strlen char.l);
        lpadding-text = padding + 2 + (strlen text);
        rpadding-rborder = padding + 2 + (strlen char.r);
        fill =
          (size + 3)
          - ((padding * 2)
            + (strlen char.l)
            + (strlen char.r)
            + (strlen text));
        border = 2;
        l = margin + 2;
        m = (padding + 2) + (strlen text);
        r = (size + 3) - (padding + (strlen text));
      };
      minlen =
        if lens.fill < (strlen char.m) + (strlen char.r)
        then (strlen char.m) + (strlen char.r)
        else lens.fill;
      #topLine = bchar.top.l + (lib.fixedWidthString size-1 bchar.top.m bchar.top.r); #(padding + (strlen fmt-title)) bchar.top.m fmt-title) + (lib.fixedWidthString (
    in ''
      printf '\e[${toString margin}C'
      printf '${bchar.top.l}'
      printf -- "${bchar.top.m}─%.0s" $(${pkgs.coreutils}/bin/seq ${
        toString padding
      })
      printf '${bchar.top.r}'

      printf '\e[${toString margin}C'
    '';
    #with lib.strings;
    #  (fixedWidthString lens.lmargin-lborder " " char.l)
    #  + (fixedWidthString lens.lpadding-text char.m text)
    #  + (fixedWidthString 10 char.m char.r);
    #(fixedWidthString lens.l char.m char.l)
    #+ (fixedWidthString lens.m char.m text)
    #+ (fixedWidthString lens.r char.m char.r);
    #(fixedWidthString until.lpadding " " char.l) # Fill area to left of box w/ space
    #+ (fixedWidthString until.rpadding char.m text) # Fill area before text w/ space or horz --, append text
    #+ (fixedWidthString until.rmargin char.m char.r); # Fill area after text w/ space or horz --, append border
  in "";
  #''
  #  printf '\e[${toString bor}'
  #'';
  #''
  #  echo
  #  echo "${ mkLineFixed { text = fmt-title; char = bchar.top; } }"
  #  echo "${ mkLineFixed { text = contents; char = bchar.mid; } }"
  #  echo "${ mkLineFixed { text = ""; char = bchar.bot; } }"
  #  echo
  #'';

  #  mkTitle = text: { cap ? "square" , innerSpace ? false , outerSpace ? false , }: let
  #      l-sym = if (strlen cap) == 1 then cap else caps.${cap}.left;
  #      r-sym = if (strlen cap) == 1 then cap else caps.${cap}.right;
  #      l = (lib.optionalString outerSpace " ") + l-sym + (lib.optionalString innerSpace " ");
  #      r = (lib.optionalString innerSpace " ") + r-sym + (lib.optionalString outerSpace " ");
  #    in l + text + r;
  #  # TODO: Select chars using stype
  #  # TODO: Split content into lines, map lines to `mkMidFixed`
  #  line = contents;
  #in
  #''
  #  ${mkTopFixed title {inherit margin padding size;}}
  #  ${mkMidFixed contents {inherit margin padding size;}}
  #  ${mkBotFixed {inherit margin padding size;}}
  #'';

  #drawBoxTopText = w: lineText: "${chars.top-left}${chars.vert} ${lineText} ${lineText}${chars.top-right}";
  #drawBoxTop = w: lineText: "${chars.top-left}";
  #drawBoxMiddle = w: lineText: "${chars.vert} ${((strlen lineText) - 4)} ${chars.vert}";
  #drawBox = {
  #  top = w: label: "${chars.top-left}${
  #    lib.strings.fixedWidthString w chars.horz (label || chars.horz)
  #  }${chars.top-right}";
  #  middle = lineText: "${chars.vert} ${lineText} ${chars.vert}";
  #  bottom = w: "${chars.bot-left}${
  #    lib.strings.fixedWidthString w chars.horz chars.horz
  #  }${chars.bot-right}";
  #};

  lines = {
    solid = ''
      printf -- "─%.0s" $(${pkgs.coreutils}/bin/seq $(${pkgs.ncurses}/bin/tput cols))
    '';
  };

  # TODO: Allow inserting word into line
  fn-solid-line = ''
    printf -- "─%.0s" $(${pkgs.coreutils}/bin/seq $(${pkgs.ncurses}/bin/tput cols))
  '';
  fn-rounded-line-top = ''
    printf -- "${chars.top-left}"
    printf -- "─%.0s" $(${pkgs.coreutils}/bin/seq "$(( $(${pkgs.ncurses}/bin/tput cols) - 2 ))")
    printf -- "${chars.top-right}"
  '';
  fn-rounded-line-bot = ''
    printf -- "${chars.bot-left}"
    printf -- "─%.0s" $(${pkgs.coreutils}/bin/seq "$(( $(${pkgs.ncurses}/bin/tput cols) - 2 ))")
    printf -- "${chars.bot-right}"
  '';
  fn-line-middle = lt: let
    len = toString ((strlen lt) + 4);
  in ''
    printf -- "${chars.vert} ${lt}"
    printf -- " %.0s" $(${pkgs.coreutils}/bin/seq "$(( $(${pkgs.ncurses}/bin/tput cols) - ${len}))")
    printf -- " ${chars.vert}"
  '';
  #fn-middle = t: let
  #  len = (strlen t) + 4;
  #in ''
  #
  #  printf -- "${chars.vert}"
  #  printf -- "LENGTH = ${strlen t}"
  #  #printf -- "LENGTH = ${len}"
  #  #printf -- " %.0s" $(${pkgs.coreutils}/bin/seq "$(( $(${pkgs.ncurses}/bin/tput cols) - ${len}))")
  #  printf -- "${chars.vert}"
  #'';
in {
  imports = [];
  environment.systemPackages = [pkgs.ncurses];
  system.activationScripts = {
    # TODO: Learn how to make sure first activation script.
    aaa-begin = {
      deps = [];
      text = let
        round.top = {
          l = "╭";
          m = "─";
          r = "╮";
        };
        round.mid = {
          l = "│";
          m = " ";
          r = "│";
        };
        round.bot = {
          l = "╰";
          m = "─";
          r = "╯";
        };
        title = "NixOS System Activation";
        size = 60;
        margin = 2;
        padding = 3;
        drawRow = txt: row:
          row.l
          + (lib.fixedWidthString (padding + (strlen txt)) row.m txt)
          + (lib.fixedWidthString (size - (1 + padding + (strlen txt))) row.m
            row.r);
        #padFinish = c: lib.fixedWidthString (size - (strlen initTop)) c round.top.r;
        #initTop = round.top.l + (padInit round.top.m) + title; # + (pad round.top.m) + round.top.r;
        #finishTop = lib.fixedWidthString (size - (strlen initTop)) round.top.m round.top.r; top = initTop + finishTop;
        #printf '\e[0;4r╭────────────────────────────────────────────────────────────╮\n'
      in ''
        echo "---BEGIN---"
        printf '\e[${toString margin}C'
        printf "${drawRow title round.top}"
        printf '\e[${toString size}D'
        printf '\e[B'
        printf "${drawRow "This is a test. ROUND" round.mid}"
        printf '\e[${toString size}D'
        printf '\e[B'
        printf "${drawRow "" round.bot}"
        echo "---DONE---"
      '';
      #echo "${chars.vert} NixOS System Activation"
      #${fn-middle "NixOS System Activation"}
      #text = ''
      #  echo "\n----------------\n"
      #  ${mkBoxFixed {
      #    title = "NixOS System Activation";
      #    contents = "This is a test. ROUND";
      #    style = "round";
      #  }}
      #  echo "\n--\n--\n"
      #  ${mkBoxFixed {
      #    title = "NixOS System Activation";
      #    contents = "This is a test. THICK";
      #    style = "thick";
      #  }}
      #  echo "\n----------------\n"
      #'';
      #
      #text=''
      #  ${fn-rounded-line-top}
      #  ${fn-line-middle "NixOS System Activation"}
      #  ${fn-rounded-line-bot}
      #'';
      supportsDryActivation = true;
    };
    zzz-end = {
      #deps = [];
      #printf '\e[;r'
      text = ''
        ${fn-solid-line}
      '';
      supportsDryActivation = true;
    };
  };

  # --- System Activation Info -----------------------------
  # TODO: Show flake inputs diff
  #system.activationScripts = let
  #  # Figlet styles
  #  # TODO: Randomize & actually use
  #  favFig = "o8";
  #  figs = [
  #    "nancyj-underlined"
  #    "nvscript"
  #    "jazmine"
  #    "o8"
  #    "ogre"
  #    "puffy"
  #    "rectangles"
  #    "rev"
  #    "roman"
  #    "rowancap"
  #    "rozzo"
  #    "cursive"
  #    "script"
  #    "slant"
  #    "standard"
  #    "starwars"
  #    "thick"
  #    "univers"
  #    "whimsy"
  #  ];
  #  fig = favFig;
  #in {
  #  # TODO: Calculate length of config.networking.hostName & fix box
  #  # TODO: Change per system type
  #  # TODO: Wrap table with border
  #  # TODO: Highlight syntax <system|global> <flake>:<inputName> <path|git+file|github>:<owner>/<repo> # <path> can have args like URL params.
  #  # TODO: Equivalent for home-manager?
  #  # TODO: Use system Nix CLI package
  #  # TODO: Write last diff to file?
  #  #${pkgs.nixUnstable}/bin/nix --extra-experimental-features nix-command store diff-closures /run/current-system "$systemConfig"
  #  # FIXME: nix-index: Locks up whole system while running & takes too long to run on each rebuild.
  #  # TODO: nix-index: Create systemd service + timer instead?
  #  update-end.text = let
  #    baseDirLog = "/var/log/nixos";
  #    diffLog = "${baseDirLog}/latest-package-diff.txt";
  #    repoHost = "github.com";
  #    repoUser = "PresqueIsleWineDev";
  #    repoProj = "nix-configs";
  #  in ''
  #    echo
  #    ${pkgs.figlet}/bin/figlet -cf ${fig} "NixOS: ${config.networking.hostName}"
  #    echo
  #    echo '╭──────────────────────────────────────────────────────────────────╮'
  #    echo '│                                                                  │'
  #    echo '│  ╭───System───────────────────────────────────────────────────╮  │'
  #    echo '│  │ Type: NixOS                                                │  │'
  #    echo "│   Host: ${config.networking.hostName}                                                   │  │"
  #    echo "│  │ Date: $(date +%c)                      │  │"
  #    echo "│  │ Repo: https://${repoHost}/${repoUser}/${repoProj}    │  │"
  #    echo '│  ╰────────────────────────────────────────────────────────────╯  │'
  #    echo '│                                                                  │'
  #    echo "│  [system] Activating system: ${config.networking.hostName}...                               │"
  #    echo '│  ╭───Nix─Path─────────────────────────────────────────────────╮  │'
  #    echo "$NIX_PATH" | tr ':' '\n' | tr '=' ' ' | column --table --output-separator ' │ ' --output-width 60 --table-column name=Input,width=20,right,trunc --table-column name=Path,wrap
  #    echo '│  ╰────────────────────────────────────────────────────────────╯  │'
  #    echo '│                                                                  │'
  #    echo '│  ╭───Nix─Registry─────────────────────────────────────────────╮  │'
  #    ${config.nix.package}/bin/nix registry list | column --table --output-separator ' │ ' --output-width 60 --table-column name=Scope,width=10,trunc --table-column name=Input --table-column name=Path,wrap
  #    echo '│  ╰────────────────────────────────────────────────────────────╯  │'
  #    echo '│                                                                  │'
  #    if [[ -e /run/current-system ]]; then
  #    echo '│  ╭───Nix─Closure─Diff─────────────────────────────────────────╮  │'
  #    echo '│  │  diff-closures = {                                         │  │'
  #    ${config.nix.package}/bin/nix --extra-experimental-features nix-command store diff-closures /run/current-system "$systemConfig" #> "${diffLog}"
  #    echo '│  │  }                                                         │  │'
  #    echo '│  ╰────────────────────────────────────────────────────────────╯  │'
  #    fi
  #    echo '│  [system] Indexing files with nix-index...                       │'
  #    #${pkgs.nix-index}/bin/nix-index >/dev/null && \
  #    echo '│  [system] Updated file index.                                    │'
  #    echo '│  [system] Updating tldr cache...                                 │'
  #    #${pkgs.tealdeer}/bin/tldr --update >/dev/null
  #    echo '│  [system] Updated tldr cache.                                    │'
  #    echo "│  [system] Activated ${config.networking.hostName}.                                          │";
  #    echo '╰──────────────────────────────────────────────────────────────────╯'
  #    echo
  #  '';
  #  update-end.deps = [];
  #};
}
