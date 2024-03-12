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
  imports = [
    omnibusStd.flakeModule
    ./android.nix
    ./hive.nix
    ./kube.nix
    ./repo.nix
    ./test.nix
    #./pops.nix
  ];

  std.std = omnibusStd.mkStandardStd {
    cellsFrom = ../../nix;
    inherit systems;
    inputs = lib.recursiveUpdate inputs.omnibus.flake.inputs inputs;
    # // { inherit climodSrc; };
    nixpkgsConfig = {
      allowUnfree = true;
      overlays = [ inputs.nix-vscode-extensions.overlays.default ];
    };
    cellBlocks = [
      #(inputs.std.blockTypes.functions "blockTypes")
      #
      # --- omnibus unused pops ---
      #  allData, darwinModules, darwinProfiles, devshellModules,
      #  example, flake, flake-parts, hive, load, microvms,
      #  overlays, self, srvos, std, systemManagerProfiles

      # --- flake.outputs ---
      # checks, hydraJobs, nixConfig, templates
      (inputs.std.blockTypes.functions "lib")
      (inputs.std.blockTypes.functions "overlays")
      (inputs.std.blockTypes.files "templates")

      # --- std missing blockTypes ---
      (inputs.std.blockTypes.arion "arion")
      (inputs.std.blockTypes.files "files")
      (inputs.std.blockTypes.kubectl "kubectl")
      (inputs.std.blockTypes.microvms "microvms")
      (inputs.std.blockTypes.namaka "namaka")
      (inputs.std.blockTypes.nixostests "nixosTests")
      (inputs.std.blockTypes.nomad "nomad")
      (inputs.std.blockTypes.nvfetcher "nvfetcher")
      (inputs.std.blockTypes.pkgs "pkgs")
      (inputs.std.blockTypes.terra "terra"
        "git@github.com:lehmanator/nix-configs.git")

      # --- config types ---
      inputs.hive.blockTypes.colmenaConfigurations

      inputs.hive.blockTypes.darwinConfigurations
      (inputs.std.blockTypes.functions "darwinModules")
      (inputs.std.blockTypes.functions "darwinProfiles")
      (inputs.std.blockTypes.functions "darwinSuites")

      (inputs.std.blockTypes.functions "devshellModules")
      (inputs.std.blockTypes.functions "devshellProfiles")
      (inputs.std.blockTypes.functions "devshellSuites")

      inputs.hive.blockTypes.diskoConfigurations
      (inputs.std.blockTypes.functions "diskoProfiles")
      (inputs.std.blockTypes.functions "diskoSuites")

      (inputs.std.blockTypes.functions "flakeModules")
      (inputs.std.blockTypes.functions "flakeProfiles")
      (inputs.std.blockTypes.functions "flakeSuites")

      (inputs.std.blockTypes.functions "hardwareConfigurations")
      (inputs.std.blockTypes.functions "hardwareProfiles")
      (inputs.std.blockTypes.functions "hardwareSuites")

      inputs.hive.blockTypes.homeConfigurations
      (inputs.std.blockTypes.functions "homeModules")
      (inputs.std.blockTypes.functions "homeProfiles")
      (inputs.std.blockTypes.functions "homeSuites")

      inputs.hive.blockTypes.nixosConfigurations
      (inputs.std.blockTypes.functions "nixosModules")
      (inputs.std.blockTypes.functions "nixosProfiles")
      (inputs.std.blockTypes.functions "nixosSuites")

      (inputs.std.blockTypes.functions "nixvimConfigurations")
      (inputs.std.blockTypes.functions "nixvimModules")
      (inputs.std.blockTypes.functions "nixvimProfiles")
      (inputs.std.blockTypes.functions "nixvimSuites")

      (inputs.std.blockTypes.functions "robotnixConfigurations")
      (inputs.std.blockTypes.functions "robotnixModules")
      (inputs.std.blockTypes.functions "robotnixProfiles")
      (inputs.std.blockTypes.functions "robotnixSuites")

      (inputs.std.blockTypes.functions "systemManagerConfigurations")
      (inputs.std.blockTypes.functions "systemManagerModules")
      (inputs.std.blockTypes.functions "systemManagerProfiles")
      (inputs.std.blockTypes.functions "systemManagerSuites")

      (inputs.std.blockTypes.functions "termuxConfigurations")
      (inputs.std.blockTypes.functions "termuxModules")
      (inputs.std.blockTypes.functions "termuxProfiles")
      (inputs.std.blockTypes.functions "termuxSuites")

      (inputs.std.blockTypes.functions "wslConfigurations")
      (inputs.std.blockTypes.functions "wslModules")
      (inputs.std.blockTypes.functions "wslProfiles")
      (inputs.std.blockTypes.functions "wslSuites")
    ];
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
