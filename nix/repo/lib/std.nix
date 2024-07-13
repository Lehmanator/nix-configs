{inputs, cell,}@cellArgs:
let
  inherit (inputs) cells;
  inherit (inputs.nixpkgs) lib;
  l = lib // builtins // cell.lib.strings;

  getUnitType = s: if l.hasPrefix "config" then "configuration" else s;
in rec 
{
  # TODO: Pass in cell name from caller location.
  getBlock = {
    nameByUnitType = u: t: "${u}${l.capitalize (l.pluralize t)}";
    targetsByUnitType = u: t: cell.${getBlock.nameByUnitType u t};
  };
  
  # TODO: getCurrentCell
  # TODO: getCellNames
}
