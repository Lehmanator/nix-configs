{inputs, ...}: let
  blockTypes =
    inputs.nixpkgs.lib.recursiveUpdate
    inputs.std.blockTypes # anything, arion, containers, data, devshells, files, functions, installables, kubectl, microvms, namaka, nixago, nixostests, nomad, nvfetcher, pkgs, runnables, terra

    inputs.hive.blockTypes
    # {colemna,darwin,disko,home,nixos}Configurations
    ;
in {
  imports = [inputs.std.flakeModule];

  std = {
    grow = {
      nixpkgsConfig = {allowUnfree = true;};
      #cellsFrom = ../../nix;
      cellsFrom = inputs.self + /nix;
      #cellsFrom = ../../nix;
      cellBlocks = with blockTypes; [
        #cellBlocks = with inputs.std.blockTypes; with inputs.hive.blockTypes; [
        (blockTypes.installables "packages" {ci.build = true;})
        (blockTypes.devshells "shells" {ci.build = true;})
        (blockTypes.functions "devshellProfiles")
        #(containers "containers" {ci.publish = true;})
        #(colmenaConfigurations "colmenaConfigurations")
        #(darwinConfigurations "darwinConfigurations")
        (blockTypes.diskoConfigurations)
        (blockTypes.functions "diskoProfiles")
        #(homeConfigurations "homeConfigurations")
        #(nixosConfigurations "nixosConfigurations")
        (blockTypes.functions "nixosProfiles")
        (blockTypes.functions "nixosModules")
        #(functions "nixosSuites")
        #(functions "homeProfiles")
        #(functions "homeModules")
        #(functions "blockTypes")
        (nixago "configs")
      ];
    };

    # Harvest: Standard outputs into Nix-CLI-compatible form (aka 'official' flake schema)
    harvest = {
      devShells = [
        [
          "repo"
          "shells"
        ]
        #  ["hive" "shells"]
        #  ["kube" "shells"]
      ];
      nixago = ["repo" "configs"];
      #packages = ["hive" "packages"];
      # a list of lists can "harvest" from multiple cells
      #[ "hive" "packages" ]
      #["kube" "packages"]
      #];
    };

    # Pick: Like `harvest` but remove the system for outputs that are system agnostic.
    pick = {
      #lib = [["hive" "lib"]];
      #lib = [ "utils" "library" ];
      devshellProfiles = [["repo" "devshellProfiles"]];
      diskoProfiles = [["hive" "diskoProfiles"]];
      nixosModules = [["hive" "nixosModules"]];
      nixosProfiles = [["hive" "nixosProfiles"]];
    };

    # Winnow: Like `harvest`, but with filters from the predicates of `winnowIf`.
    #winnow = {
    #  packages = [ "app3" "packages" ];
    #};

    # WinnowIf: Set the predicates for `winnow`.
    #winnowIf = {
    #  packages = n: v: n=="foo";
    #};
  };

  flake = {
    blockTypes = {
      std = inputs.std.blockTypes;
      hive = inputs.hive.blockTypes;
      all = blockTypes;
    };
  };
}
