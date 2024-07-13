{ inputs, cell, }@commonArgs:
let
  inherit (inputs.nixpkgs) lib;
  getInputsNixos = inputs.flops.flake.pops.default.setInitInputs (inputs.projectRoot + /nix/hive/nixos);
  mkModule = { name, conf, t ? "nixos", program ? null, }@profile:
    let
      proname = if program == null || program == "" then name else "${program}-${name}";
    in
    { inputs, config, lib, pkgs, ... }:
    let cfg = config.profiles.${proname};
    in {
     # TODO: Use lib.applyModuleArgsIfFunction key f args
      inherit (conf) imports;
      options.profiles.${proname}.enable = lib.mkEnableOption "Profile for ${program}: ${name}";
      config = lib.mkIf cfg.enable (builtins.removeAttrs conf [ "imports" "options" ]); # "config"
      #{ # Insert profile contents here. };
    };
in
# inputs.omnibus.pops.nixosProfiles.addLoadExtender { load = {
{
  src = ../nixos/profiles;
  type = "nixosProfiles";
  inputs = commonArgs // {
    #inherit cell inputs;
    # TODO: Workaround: Make this into a nixosModule instead, fix profiles to read config.userPrimary??
    user = "sam";
    username = "sam";
  };
#};
}

#(inputs.omnibus.pops.nixosProfiles.addLoadExtender {
#  #src = ../nixos/profiles;
#  load = {
#    src = ../nixos/profiles;
#    type = "nixosProfiles";
#    inputs = {
#      inherit cell;
#      inputs = (builtins.removeAttrs inputs [ "self" ])
#        // inputs.omnibus.flake.inputs // {
#        #
#      };
#    };
#  };
#})
#.addExporter (inputs.POP.extendPop inputs.flops.haumea.pops.exporter
#  (self: _super: {
#    exports = {
#      nixosModule = { inputs, config, lib, pkgs, ... }: {
#        imports = lib.mapAttrsFlatten (n: v: v) self.exports.nixosModules;
#      };
#      nixosModules = lib.mapAttrs'
#        (n: v:
#          lib.nameValuePair ("profile-" + n) (mkModule {
#            name = n;
#            conf = v;
#            t = "nixos";
#          }))
#        self.layouts.default;
#      homeManagerModules = lib.mapAttrs'
#        (n: v:
#          lib.nameValuePair ("profile-" + n) (mkModule {
#            name = n;
#            conf = v;
#            t = "homeManager";
#          }))
#        self.layouts.default;
#      homeManagerModule = { inputs, config, lib, pkgs, ... }: {
#        imports = lib.mapAttrsFlatten (n: v: v) self.exports.homeManagerModules;
#      };
#    };
#  }))
