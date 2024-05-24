{ inputs, ... }@args:
let inherit (inputs) nixpkgs omnibus;
in nixpkgs.lib // builtins // {
  inherit (omnibus.lib) bird omnibus haumea recursiveAttrValues;
  attrsets = omnibus.lib.attrsets // nixpkgs.lib.attrsets;
  types = omnibus.lib.types // nixpkgs.lib.types;
}
