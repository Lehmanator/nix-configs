{ inputs, cell, }@commonArgs:
let
  l = inputs.nixpkgs.lib // builtins;

  # Filters inputs to only those that have attrs "overlays" | "overlay"
  filter =  n: v:
      l.isAttrs v && (n != "lib") && (n != "self")
    && ((l.hasAttr "overlays" v) || (l.hasAttr "overlay" v))
    ;

  # Merges <input>.overlay into <input>.overlays.default
  uniformer = l.mapAttrs (i: v:
    let
      overlays = if (l.hasAttr "overlays" v) then v.overlays else {};
      overlay = if (l.hasAttr "overlay" v) then { default = v.overlay; } else {};
    in
      overlays // overlay
  );

  # Removes duplicate overlay matching input name if has default
  overlayFilter = l.mapAttrs (n: v: 
    if (l.hasAttr "default" v) && (l.hasAttr n v) then
      builtins.removeAttrs v [n]
    else v);

  # Renames each <input>.overlays.<name> to <input>-<name>
  renamer = l.mapAttrs (i: v: l.mapAttrs' (on: ov: l.nameValuePair (i+"-"+on) ov) v);

in
# TODO: Rename to overlaysAttrs.nix
# TODO: Create file overlaysList.nix - import super.overlayAttrs, flatten into list
i: l.mergeAttrsList (l.attrValues (renamer (overlayFilter (uniformer (l.filterAttrs filter i)))))
