{ inputs, cell }:
let
  inherit (inputs.nixpkgs) lib;
  inherit (cell.lib.strings) fixedWidthStringAppend splitStringSized;
in
rec {
  mkShellCategoryDivider = name: size: let
    prefix = "# +---[";
    suffix = let
      chars-left = size - (lib.stringLength (prefix+name+2));
    in "]${lib.strings.replicate "-" chars-left}+";
  in "\n${prefix}${name}${suffix}";
  mkShellSection = name: size: code: lib.concatLines [(mkShellCategoryDivider name size) code];
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

  
}
