{ inputs, cell, }@commonArgs:
# TODO: Turn into inputsTransformer POP
let
  flatten = cell.lib.flattenInputAttrs;
  filter = n: v:
    builtins.isAttrs v && v != { } && (n != "lib") && (n != "self")
    && ((builtins.hasAttr "homeManagerModules" v && v.homeManagerModules != { })
    || ((builtins.hasAttr "hmModules" v) && v.hmModules != { })
    || ((builtins.hasAttr "homeModules" v) && v.homeModules != { })
    || (builtins.hasAttr "homeManagerModule" v)
    || (builtins.hasAttr "hmModule" v) || (builtins.hasAttr "homeModule" v));

  renamer = builtins.mapAttrs (n: v:
    if (builtins.hasAttr "homeManagerModules" v) then
      v.homeManagerModules
    else if (builtins.hasAttr "hmModules" v) then
      v.hmModules
    else if (builtins.hasAttr "homeModules" v) then
      v.homeModules
    else if (builtins.hasAttr "homeManagerModule" v) then {
      default = v.homeManagerModule;
    } else if (builtins.hasAttr "hmModule" v) then {
      default = v.hmModule;
    } else {
      default = v.homeModule;
    });
  #omnibus = inputs.nixpkgs.lib.filterAttrs filter inputs.omnibus.flake.inputs;
  #flake = inputs.nixpkgs.lib.filterAttrs filter inputs;
in
i: flatten (renamer (inputs.nixpkgs.lib.filterAttrs filter i))
