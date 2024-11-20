{ pkgs, ... }:

# TODO: Import boxes definition generator lib.
# TODO: Colorize boxes
let
  inherit (pkgs.lib) getExe;
  inherit (pkgs.lib.strings) fixedWidthString replicate;
  boxes  = getExe pkgs.boxes;

  # Wrap commands in pretty box using unicode box chars.
  # TODO: Test if script output is empty and hide borders when empty.
  icons = rec {
    inherit (environment) nixos home-manager;
    environment = {
      nixos = " ";
      home-manager = " ";
      default = environment.nixos;
    };
    delimiters = {
      brackets-square = { beg="["; end="]"; };
      default = delimiters.brackets-square;
      inherit (delimiters.default) beg end;
    };
    box = rec {
      square = rec {
        horizontal   = "─"; n =horizontal; s=horizontal;
        vertical     = "│"; e =vertical;   w=vertical;
        top-left     = "┌"; nw=top-left; 
        top-right    = "┐"; ne=top-right;
        bot-left     = "└"; sw=bot-left;   bottom-left =bot-left;
        bot-right    = "┘"; se=bot-right;  bottom-right=bot-right;
        mid-left     = "├"; 
        mid-right    = "┤";
      };
      round = square // rec {
          top-left     = "╭"; nw = top-left; 
          top-right    = "╮"; ne = top-right;
          bottom-left  = "╰"; sw = bottom-left;
          bottom-right = "╯"; se = bottom-right;
      };
      icon-corner-top-left  = square // rec { top-left =environment.default; nw=top-left; };
      icon-corner-top-right = square // rec { top-right=environment.default; ne=top-right; };
      icon-corner-top       = icon-corner-top-left // rec { top-right   =environment.default; ne=top-right; };
      icon-corner-all       = icon-corner-top      // rec { 
        bottom-left =environment.default; sw=bottom-left;
        bottom-right=environment.default; se=bottom-right;
      };
      icon-corner = square // rec {
          top-left     = environment.default; nw=top-left; 
          top-right    = environment.default; ne=top-right;
          bottom-left  = environment.default; sw=bottom-left;
          bottom-right = environment.default; se=bottom-right;
      };
      default = round;
      inherit (default) bottom-left bottom-right
        nw n ne    top-left horizontal top-right
         w    e    mid-left   vertical mid-right
        sw s se    bot-left            bot-right
      ;
    };
  };

  styles = with icons.delimiters; {
    # --icon----[title]--
    outside           = t: i: sp: (pad 1  i                ) + pad [beg end] t;

    # --[icon]--[title]--
    outside-bracketed = t: i: sp: (pad 1  (pad [beg end] i)) + pad ([sp 0] (pad [beg end] t));

    # --[icon title]--
    inside            = t: i: sp: (pad sp (pad [beg end] (i + " " + t)));
  };

  # Wraps string with padding character. Handles left/right/symmetric via int/list/attrs
  pad = counts: str: with icons; let    
    parseItem = i: if builtins.isList   i then  i
              else if builtins.isInt    i then [i box.n] 
              else if builtins.isString i then [1     i]
              else                             [0 box.n];
    mkPad = l: replicate (builtins.head l) (pkgs.lib.last l);
    l=let i=if builtins.isList counts then builtins.head counts else if builtins.isAttrs counts then counts.beg else counts; in mkPad (parseItem i);
    r=let i=if builtins.isList counts then pkgs.lib.last counts else if builtins.isAttrs counts then counts.end else counts; in mkPad (parseItem i);
  in l + str + r;
  mkRegion  = variant: r: "    ${r} (\"${icons.box.${r}}\")";
  mkRegions = variant: title: icon:  ''
      nnw ("${styles.inside title icon 4}")
      ${builtins.concatStringsSep "\n" (builtins.map (mkRegion variant) [ "nw" "n" "ne" "e" "se" "s" "sw" "w" ])}
  '';
  sections = title: icon: with icons.box; {
    box = ''
      NW  ("${top-left}") NNW ("${styles.inside title icon 4}") N ("${n}") NE ("${top-right}")
      W   ("${w}")                                                          E ("${e}")
      SW  ("${bot-left}")                                       S ("${s}") SE ("${bot-right}")
    '';
    top = ''
      NW  ("${top-left}") NNW ("${styles.inside title icon 4}") N ("${n}") NE ("${top-right}")
      W   ("${w}")                                                          E ("${e}")
    '';
    mid = ''
      NW  ("${mid-left}") NNW ("${styles.inside title icon 4}") N ("${n}") NE ("${mid-right}")
      W   ("${w}")                                                          E ("${e}")
    '';
    bot = ''
      NW  ("${mid-left}") NNW ("${styles.inside title icon 4}") N ("${n}") NE ("${mid-right}")
      W   ("${w}")                                                          E ("${e}")
      SW  ("${bot-left}")                                       S ("${s}") SE ("${bot-right}")
    '';
  };

  # --- Standalone ---
  # TODO: Use title to calculate inner spaces & vert-border chars (20 spaces)
  mkBox = variant: title: icon: with icons.box; ''
    BOX ansi-title-${variant}
    AUTHOR   "Lehmanator"
    DESIGNER "(public domain)"
    TAGS     ("box", "simple", "unicode")
    SAMPLE
        ${nw}──[<title>]─────${ne}
        ${w} This is a test    ${e}
        ${w} sample of my      ${e}
        ${w} titled box design ${e}
        ${w}                   ${e}
        ${w}                   ${e}
        ${w}                   ${e}
        ${w}                   ${e}
        ${sw}───────────────────${se}
    ENDS
    SHAPES {
        ${mkRegions variant title icon}
    }
    PADDING { horiz 1 }
    ELASTIC (n,e,s,w)
    END ansi-title-${variant}
  '';
  mkBoxSection = sect: variant: title: icon: with icons.box; ''
    BOX ansi-title-${variant}-${sect}
    AUTHOR   "Lehmanator"
    DESIGNER "(public domain)"
    TAGS     ("box", "simple", "unicode")
    SAMPLE
        ${mid-left}──[<title>]─────${mid-right}
        ${w} This is a test    ${e}
        ${w} sample of my      ${e}
        ${w} titled box design ${e}
        ${w}                   ${e}
        ${w}                   ${e}
        ${w}                   ${e}
        ${w}                   ${e}
        ${mid-left}───────────────────${mid-right}
    ENDS
    SHAPES {
        ${(sections title icon).${sect}}
    }
    PADDING { horiz 1 }
    ELASTIC (n,e,s,w)
    END ansi-title-${variant}-${sect}
  '';
  mkBoxNixOS = title: with icons; ''
    BOX nixos-title-${title}
    AUTHOR   "Lehmanator"
    DESIGNER "(public domain)"
    TAGS     ("box", "simple", "unicode")
    SAMPLE
        ${box.nw}──[${environment.nixos} <title>]─────${box.ne}
        ${box.w}                   ${box.e}
        ${box.w}                   ${box.e}
        ${box.w}                   ${box.e}
        ${box.w}                   ${box.e}
        ${box.w}                   ${box.e}
        ${box.w}                   ${box.e}
        ${box.w}                   ${box.e}
        ${box.sw}───────────────────${box.se}
    ENDS
    SHAPES {
        ${mkRegions "round" title environment.nixos}
    }
    PADDING { horiz 1 }
    ELASTIC (n,e,s,w)
    END ansi-title-${variant}
  '';

  # Generate a script to:
  # 1. Create a temporary file containing the box definition
  # 2. Wrap the command using the boxes definition in the created file.
  # 3. Delete the file containing the boxes definition
  mkBoxFile = variant: title: icon: cmd: ''
    f=`mktemp`
    cat > $f << EOF
    PARENT :global:
    ${mkBox variant title icon}

    ${mkBoxSection "top" variant title icon}
    ${mkBoxSection "mid" variant title icon}
    ${mkBoxSection "bot" variant title icon}
    ${mkBoxSection "box" variant title icon}

    EOF
    # echo
    # cat $f
    ${cmd} | ${boxes} --config $f  --align hlvt --indent box --size "$((COLUMNS-4))" --padding h1v0
    rm $f
  '';

  mkBoxFile2 = variant: title: icon: cmd: ''
    f=`mktemp`
    cat > $f << EOF
    PARENT :global:
    ${mkBox variant title icon}

    ${mkBoxSection "top" variant title icon}
    ${mkBoxSection "mid" variant title icon}
    ${mkBoxSection "bot" variant title icon}
    ${mkBoxSection "box" variant title icon}

    EOF
    # echo
    # cat $f
    ${cmd} | ${boxes} --config $f  --align hlvt --indent box --size "$((COLUMNS-4))" --padding h1v0 --design ansi-title-${variant}-top
    ${cmd} | ${boxes} --config $f  --align hlvt --indent box --size "$((COLUMNS-4))" --padding h1v0 --design ansi-title-${variant}-mid
    ${cmd} | ${boxes} --config $f  --align hlvt --indent box --size "$((COLUMNS-4))" --padding h1v0 --design ansi-title-${variant}-bot
    ${cmd} | ${boxes} --config $f  --align hlvt --indent box --size "$((COLUMNS-4))" --padding h1v0 --design ansi-title-${variant}-box
    rm $f
  '';
in {
  inherit
    mkBoxFile
    mkBoxFile2
    mkBox
  ;
}
