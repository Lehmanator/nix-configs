{ inputs, debug, l, i, ... }@commonArgs:
let
  i = {
    inputsSelf = inputs.self;
    inputsFlake = inputs;
    inputsLoader = inputs.omnibus.lib.omnibus.loaderInputs;
    inputsOmnibus = inputs.omniibus.flake.inputs;
    inputsExtra = {
      inherit (inputs.omnibus.flake.inputs) climodSrc flake-parts omnibus std;
    };
  };
  #builtins.trace
  #  (builtins.concatStringsSep "\n" [
  #    "src/pops/std.nix"
  #    "system = ${inputs.nixpkgs.system or builtins.currentSystem}"
  #    "  args = ${builtins.concatStringsSep "," (builtins.attrNames commonArgs)}"
  #    "inputs = ${builtins.concatStringsSep "," (builtins.attrNames inputs)}"
  #    ""
  #  ])
in
inputs.omnibus.pops.std {
  inputs = commonArgs // {
    inherit debug;
    systems = [ "x86_64-linux" "aarch64-linux" ];
    projectRoot = ../.;
    flakeRootDir = ../.;
    lib = l;
    inputs = inputs // i // i.inputsExtra;
  };
}
