{ inputs, config, ... }:
let
  inherit (config) systems;
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.omnibus.flake.inputs) climodSrc std flake-parts;
  omnibusStd = (inputs.omnibus.pops.std {
    inputs.inputs = lib.recursiveUpdate inputs.omnibus.flake.inputs inputs;
  }).exports.default;
in
{
  imports =
    [ omnibusStd.flakeModule ./hive.nix ./kube.nix ./repo.nix ./test.nix ];

  std.std = omnibusStd.mkStandardStd {
    cellsFrom = ../../nix;
    inherit systems;
    inputs = lib.recursiveUpdate inputs.omnibus.flake.inputs inputs;
    # // { inherit climodSrc; };
    nixpkgsConfig = {
      allowUnfree = true;
      overlays = [ inputs.nix-vscode-extensions.overlays.default ];
    };
  };

  #std.grow = {
  #  #cellsFrom = inputs.self + /nix;
  #  cellBlocks = with blockTypes; [
  #    (installables "packages" { ci.build = true; })
  #    (devshells "shells" { ci.build = true; })
  #    (functions "devshellProfiles")
  #    (containers "containers" {ci.publish = true;})
  #    (colmenaConfigurations "colmenaConfigurations")
  #    (darwinConfigurations "darwinConfigurations")
  #    (diskoConfigurations)
  #    (functions "diskoProfiles")
  #    (homeConfigurations "homeConfigurations")
  #    (nixosConfigurations "nixosConfigurations")
  #    (functions "nixosProfiles")
  #    (functions "nixosModules")
  #    (functions "nixosSuites")
  #    (functions "homeProfiles")
  #    (functions "homeModules")
  #    (functions "blockTypes")
  #    (nixago "configs")
  #  ];
  #};

  # Winnow: Like `harvest`, but with filters from the predicates of `winnowIf`.
  #std.winnow = { packages = [ "app3" "packages" ]; };

  # WinnowIf: Set the predicates for `winnow`.
  #std.winnowIf = { packages = n: v: n=="foo"; };

  flake = {
    inherit (omnibusStd) flakeModule;
    blockTypes = rec {
      std =
        inputs.std.blockTypes; # anything, arion, containers, data, devshells, files, functions, installables, kubectl, microvms, namaka, nixago, nixostests, nomad, nvfetcher, pkgs, runnables, terra
      hive =
        inputs.hive.blockTypes; # {colemna,darwin,disko,home,nixos}Configurations
      all = std // hive;
    };
    omnibus = {
      inherit (inputs.omnibus) pops;
      std = omnibusStd;
      inputs = lib.recursiveUpdate inputs.omnibus.flake.inputs inputs;
    };
    flakeModules.omnibusStd = omnibusStd.flakeModule;
  };
}
