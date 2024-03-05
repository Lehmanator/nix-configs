# omnibus-std
#cell.pops.packages.exports.derivations or {}
# std (plain)
{
  inputs,
  cell,
}: let
  inherit (inputs.haumea.lib) load loaders matchers transformers;
  inherit (inputs.nixpkgs) lib;
  pkgs = inputs.nixpkgs.legacyPackages;
  #nvfetcher = load {
  #  src = ./_sources;
  #  loader = loaders.default;
  #  matcher = matchers.nix;
  #  #transformer = transformers.;
  #};
  #nvfetcher = inputs.nixpkgs.legacyPackages.callPackage ./packages/_sources/generated.nix {};
  callPackages = load {
    src = ./packages;
    loader = i: path: inputs.nixpkgs.callPackage path {};
    #loader = loaders.callPackage; # inputs: path: inputs.nixpkgs.legacyPackages.callPackage path {};
    #matcher = matchers.nix;
    transformer = transformers.liftDefault;
    inputs = {inherit inputs cell lib;};
  };
in
  callPackages
#inputs.nixpkgs.lib.recursiveUpdate callPackages nvfetcher
