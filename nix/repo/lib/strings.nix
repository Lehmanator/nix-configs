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
  # TODO: More heuristics for exceptions
  pluralizeWords = applyOperationToWords pluralize;
  pluralize = str:
  let
    vowels = ["a" "e" "i" "o" "u"]; #"y"
    endings-es = ["x" "c" "ss" "sh"] ++ (builtins.map (v: "${v}s") vowels);
    hasPluralIrregularEnd = s: l.any (e: l.hasSuffix "${e}es" s) endings-es;
    hasIrregularEnd = s: l.any (e: l.hasSuffix "${e}" s) endings-es;
  in
    # TODO: Handle plurals that keep singular form.
    # Plural w/ irregular ending
    if hasPluralIrregularEnd str then str
    # Singular w/ irregular ending
    else if hasIrregularEnd str then str+"es"
    # Plural w/ normal ending
    else if l.hasSuffix "s" then str
    # Singular w/ normal ending
    else str + "s";
}
