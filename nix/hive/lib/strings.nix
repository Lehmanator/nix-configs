{cell, config, lib, pkgs, ...}:
let
  l = lib // cell.lib // builtins;
in
rec {
  length = str: l.strings.stringLength;

  # Replace 8, 4, or 2 spaces w/ tab
  # TODO: Make size configurable?
  # TODO: Handle code where multiple tabs allowed in succession
  replaceSpaces  = c: l.replaceStrings ["        " c] ["    " c] ["  " c];
  collapseChars  = c: l.strings.filter (s: s!=c) (replaceSpaces c);
  splitCharCollapse = c: str: l.splitString c (collapseChars c str);
  spacesToTabs   = replaceSpaces "\t";
  spacesToLines  = replaceSpaces "\n";
  spacesToSpace  = replaceSpaces " ";

  # Split strings w/ delimiter into list (considers 8/4/2 spaces as tab)
  splitTabs = splitCharCollapse "\t";
  splitLines = splitCharCollapse "\n";
  splitSpace = splitCharCollapse " ";
  splitLineWhitespace = str: l.flatten (
    if l.isList (splitTabs str) then
      builtins.map splitSpace (splitTabs str)
    else splitSpace str
  );
  splitLinesWhitespace = str: builtins.map (s: l.splitString "\n" s) (splitLineWhitespace str);

  /**
    Create a fixed width string with additional suffix to match
    required width.

    This function will fail if the input string is longer than the
    requested length.

    # Inputs

    `width`

    : 1\. Function argument

    `filler`

    : 2\. Function argument

    `str`

    : 3\. Function argument

    # Type

    ```
    fixedWidthString :: int -> string -> string -> string
    ```

    # Examples
    :::{.example}
    ## `fixedWidthStringAppend` usage example

    ```nix
    fixedWidthStringAppend 5 "-" (toString 15)
    => "15---"
    ```
  */
  fixedWidthStringAppend = width: filler: str:
    let
      strw = lib.stringLength str;
      reqWidth = width - (lib.stringLength filler);
    in
      assert lib.assertMsg (strw <= width)
        "fixedWidthString: requested string length (${
          toString width}) must not be shorter than actual length (${
            toString strw})";
      if strw == width then str else (fixedWidthStringAppend reqWidth filler str) + filler;
  fixedWidthStringPrepend = l.fixedWidthString;

  # Split strings into list of strings with max length
  splitStringSized = str: size: if builtins.stringLength str <= size then [str] else lib.flatten [
    [(builtins.substring 0 size str)]
    (splitStringSized (builtins.substring size (builtins.stringLength str) str) size)
  ];
  
}
