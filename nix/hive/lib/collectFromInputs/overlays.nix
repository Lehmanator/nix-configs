{ inputs, cell, }@commonArgs:
let
  filter = n: v:
    builtins.trace
      "${n}: ${builtins.concatStringsSep "," (builtins.attrNames v)}"
      builtins.isAttrs
      v && (n != "lib") && (n != "self")
    && ((builtins.hasAttr "overlays" v) || (builtins.hasAttr "overlay" v));
  renamer = builtins.mapAttrs (n: v:
    if (builtins.hasAttr "overlays" v) then
      v.overlays
    else {
      default = v.overlay;
    });
in
i: renamer (inputs.nixpkgs.lib.filterAttrs filter i)
