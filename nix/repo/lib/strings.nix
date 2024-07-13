{inputs, cell,}@cellArgs:
let
  inherit (inputs.nixpkgs) lib;
  l = lib // builtins;
in rec
{
  # Split string into word list, apply f to each, recombine 
  # TODO: Similar for camelCase, kebab-case, snake_case
  applyOperationToWords = f: str: builtins.concatStringSep " "
    (builtins.map f (l.splitString " " str));

  # Capitalize first char of a word
  capitalize = str: (lib.strings.head str) + (lib.strings.tail str);
  capitalizeWords = applyOperationToWords capitalize;

  # Make word plural
  # TODO: Heuristics for exceptions
  pluralize = str: str + "s";
  pluralizeWords = applyOperationToWords pluralize;
  
}
