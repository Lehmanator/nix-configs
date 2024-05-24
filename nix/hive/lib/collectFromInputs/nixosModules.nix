{ inputs, cell, }@commonArgs:
let
  filter = n: v:
    builtins.isAttrs v && (n != "lib") && ((builtins.hasAttr "nixosModules" v)
    || (builtins.hasAttr "nixosModule" v));
  renamer = builtins.mapAttrs (n: v:
    if (builtins.hasAttr "nixosModules" v) then
      v.nixosModules
    else {
      default = v.nixosModule;
    });
in
i: renamer (inputs.nixpkgs.lib.filterAttrs filter i)
