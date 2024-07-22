{ inputs, cell }:
let
  inherit (inputs.nixpkgs) lib;
  inherit (cell.lib.strings) fixedWidthStringAppend splitStringSized;
in
rec {
  # mkShellCategoryDivider = name: size: let
  #   prefix = "# +---[";
  #   suffix = let
  #     chars-left = size - (lib.stringLength (prefix+name+2));
  #   in "]${lib.strings.replicate "-" chars-left}+";
  # in "\n${prefix}${name}${suffix}";
  # mkShellSection = name: size: code: lib.concatLines [(mkShellCategoryDivider name size) code];

  mkShellComment = line: "# ${line}";
  wrapLineBox = line: size: "|${fixedWidthStringAppend (size - 4) " " line}|";
  prefixLineComment = line: "# ${line}";

  # Wraps a line with box-drawing chars and comment char prefix
  mkShellSectionWrappedLine = line: size: prefixLineComment (wrapLineBox line (size - 2));

  # Splits into multiple lines with max size and wraps each with box-drawing chars + comment prefix
  mkShellSectionDescription = desc: size:  let
    max_text_length = size - 6;
    strings = splitStringSized desc max_text_length;
  in map (s: mkShellSectionWrappedLine s size) strings;

  # TODO: Allow specifying caps, filler, wrapper chars
  # TODO: Better defaults, named sets of chars?
  mkShellSectionDivider = name: size: {
    caps ? ["+" "+"],
    wrapper ? ["[" "]"],
    filler ? "-",
    filler-prefix ? "---"
  }@c: let
    wrapper = if (lib.stringLength > 0) && (name != " ") then [filler filler] else c.wrapper;
    prefix = "${lib.elemAt c.caps 0}${c.filler-prefix}${lib.elemAt wrapper 0}";
    known = "${prefix}${name}${lib.elemAt wrapper 1}";
    size-rem = ((size - 2) - (lib.stringLength (lib.elemAt c.caps 1)));
  in prefixLineComment (fixedWidthStringAppend size-rem c.filler known) + (lib.elemAt c.caps 1);

  mkShellSectionBox = size: name: desc: { }@chars: lib.concatLines [
    (mkShellSectionDivider name size {})  # Top w/ name
    (mkShellSectionDescription desc size) # Desc lines
    (mkShellSectionDivider "" size {})    # Bottom
  ];

  # TODO: mkShellSections
  # TODO: mkShellSectionsDesc
  
}
