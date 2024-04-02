{
  inputs,
  cell,
} @ commonArgs: let
  inherit (inputs) omnibusStd; # cellsFrom cellsFrom' _pops ;
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.omnibus) pops;
  inherit (inputs.omnibus.pops) load homeProfiles nixosProfiles;
  cellName = builtins.baseNameOf ./.;
  # TODO: Which pops are available in `mkBlocks`, omnibus, hivebus?
  #
  # mkBlocks: configs, data, devshellProfiles, jupyenv, packages, pops, scripts, shells, tasks
  #
  # TODO: Kubernetes, containers, tests, checks, jupyenv, nixago, secrets
  # TODO: Try: `src = cellsFrom + /${cellName}/packages;`
  #lib.recursiveUpdate (
in
  omnibusStd.mkBlocks.pops commonArgs {
    lib = pops.load {
      src = ./lib;
      loader = inputs.haumea.lib.loaders.default;
      inputs = {
        inherit inputs cell;
        #inherit (inputs.nixpkgs) lib;
        #pkgs = inputs.nixpkgs;
      };
    };
    packages = with inputs.nix-vscode-extensions.extensions.${inputs.nixpkgs.system}; let
      openvsx = open-vsx-release // open-vsx;
      vscode-marketplace = vscode-marketplace-release // vscode-marketplace;
      nixpkgs =
        inputs.nixpkgs.legacyPackages.extend
        inputs.nix-vscode-extensions.overlays.default;
    in {
      src = ./packages;
      #loader = __inputs__: path:
      #  ((__inputs__.inputs.nixpkgs.extend
      #      (_: _: {inherit __inputs__;}))
      #    .extend
      #    inputs.nix-vscode-extensions.overlays.default)
      #  .callPackage
      #  path {};
      inputs = {
        inherit cell;
        inherit inputs;
        #inputs = inputs // {inherit nixpkgs;};
        #open-vsx =
        #inputs.nix-vscode-extensions.extensions.open-vsx #${inputs.nixpkgs.system}.open-vsx;
        #inputs = (inputs // { nixpkgs = inputs.nixpkgs.extend inputs.nix-vscode-extensions.overlays.default; });
        #inputs.nixpkgs // {
        #  vscode-extensions-openvsx =
        #    inputs.nix-vscode-extensions.extensions.${inputs.nixpkgs.system}.open-vsx;
        #  vscode-extensions =
        #    lib.fold (a: b: lib.recursiveUpdate a b)
        #    inputs.nixpkgs.vscode-extensions
        #    (with inputs.nix-vscode-extensions.extensions.${inputs.nixpkgs.system}; [
        #      vscode-marketplace-release
        #      vscode-marketplace
        #      open-vsx-release
        #      open-vsx
        #    ]);
        #};
      };
    };

    # --- DevShells -------------------------------------------
    #devshellModules = { src = ./devshellModules; inputs = { inherit inputs cell; }; };
    devshellProfiles = {
      src = ./devshellProfiles;
      inputs = {inherit inputs cell;};
    };
    devshellSuites = pops.nixosProfiles.addLoadExtender {
      load = {
        src = ./devshellSuites;
        type = "nixosProfilesOmnibus";
        inputs = {inherit inputs cell;};
      };
    };
    shells = {
      src = ./shells;
      inputs = {inherit inputs cell;};
    };

    # --- Disko -------------------------------------------
    diskoConfigurations = pops.nixosProfiles.addLoadExtender {
      load = {
        src = ./diskoConfigurations;
        inputs = {inherit inputs cell;};
      };
    };
    diskoProfiles = pops.nixosProfiles.addLoadExtender {
      load = {
        src = ./diskoProfiles;
        type = "nixosProfiles";
      }; # inputs = { inherit inputs cell; };
    };
    diskoSuites = pops.nixosProfiles.addLoadExtender {
      load = {
        src = ./diskoSuites;
        type = "nixosProfilesOmnibus";
      };
    };

    # --- Hardware -------------------------------------------
    hardwareProfiles = pops.nixosProfiles.addLoadExtender {
      load = {
        src = ./hardwareProfiles;
        type = "nixosProfiles";
      };
    };
    hardwareSuites = pops.nixosProfiles.addLoadExtender {
      load = {
        src = ./hardwareSuites;
        type = "nixosProfilesOmnibus";
        inputs = {inherit inputs cell;};
      };
    };

    # --- Home Manager -------------------------------------------
    #homeConfigurations = pops.load {
    #  #homeConfigurations = pops.nixosProfiles.addLoadExtender {
    #  #homeConfigurations = pops.homeProfiles.addLoadExtender {
    #  #  load = {
    #  src = ./homeConfigurations;
    #  #type = "nixosProfiles";
    #  #loader = [ inputs.haumea.lib.matchers.nix inputs.haumea.lib.loaders.scoped ];
    #  transformer = inputs.haumea.lib.transformers.liftDefault;
    #  inputs = { inherit inputs cell; };
    #  #};
    #};
    homeModules = {src = ./homeModules;};
    homeProfiles = {
      src = ./homeProfiles;
      #loader = with inputs.haumea.lib; [ matchers.nix loaders.scoped ];
      type = "nixosProfiles";
      inputs = {inherit inputs cell;};
      transformer = [
        inputs.haumea.lib.transformers.liftDefault
        inputs.omnibus.lib.haumea.removeTopDefault
      ];
      #transformer = inputs.haumea.lib.transformers.liftDefault;
    };
    homeSuites = pops.homeProfiles.addLoadExtender {
      load = {
        src = ./homeSuites;
        type = "nixosProfiles";
        inputs = {inherit inputs cell;};
      }; # type = "nixosProfilesOmnibus";
    };
    userProfiles = pops.homeProfiles.addLoadExtender {
      load = {
        src = ./userProfiles;
        type = "nixosProfilesOmnibus";
        #transformer = inputs.haumea.lib.transformers.liftDefault;
        inputs = {inherit inputs cell;};
      };
    };

    # --- NixOS -------------------------------------------
    nixosConfigurations = {
      src = ./nixosConfigurations;
      inputs = {inherit inputs cell;};
    };
    nixosModules = {src = ./nixosModules;};
    nixosProfiles = {
      src = ./nixosProfiles;
      type = "nixosProfiles";
    };
    nixosSuites = pops.nixosProfiles.addLoadExtender {
      load = {
        src = ./nixosSuites;
        type = "nixosProfilesOmnibus";
      };
    };

    # --- Nixvim -------------------------------------------
    #nixvimConfigurations = {
    #  src = ./nixvimConfigurations;
    #  inputs = { inherit inputs cell; };
    #};
    nixvimProfiles = pops.nixosProfiles.addLoadExtender {
      load = {
        # src = ./nixvim/profiles; inputs = { inherit inputs cell; };
        src = ./nixvimProfiles;
        type = "nixosProfiles";
        inputs = commonArgs;
      };
    };
    nixvimModules = pops.nixosModules.addLoadExtender {
      load = {
        src = ./nixvimModules;
        type = "nixosModules";
        inputs = commonArgs;
      };
    };
    nixvimSuites = pops.nixosProfiles.addLoadExtender {
      load = {
        src = ./nixvimSuites;
        type = "nixosProfiles";
        #type = "nixosProfilesOmnibus";
        inputs = commonArgs;
      };
    };

    # --- Hive ---------------------------------------------
    #hive = pops.hive; #. { src = ./hosts; };
    #hive = pops.hive.addLoadExtender { load = { src = ./hosts; }; };
  }
#
#
# --- OLD ATTEMPT ------------------------------------------
## Attr args should match that of Haumea load
#
#omnibusStd.mkBlocks.pops commonArgs ({
#configs = { src = cellsFrom + /${cellName}/configs; };
#containers = { src = cellsFrom + /${cellName}/configs; };
#data = { src = cellsFrom' + /${cellName}/data; };
#lib = { src = cellsFrom + /${cellName}/lib; };
#pops = { src = cellsFrom + /${cellName}/pops; };
#shells = { src = cellsFrom /${cellName}/shells; };
#
#robotnixConfigurations = { src = cellsFrom + /${cellName}/robotnixConfigurations; };
#robotnixModules = { src = cellsFrom + /${cellName}/robotnixModules; };
#robotnixProfiles = { src = cellsFrom + /${cellName}/robotnixProfiles; };
#
#devshells = { src = cellsFrom + /${cellName}/devshellModules; };
#devshellModules = { src = cellsFrom + /${cellName}/devshellModules; };
#devshellProfiles = {
#  src = cellsFrom + /${cellName}/devshellProfiles;
#  inputs.inputs = { inherit (inputs.std.inputs) devshell; };
#};
#
#packages = {
#  src = cellsFrom + /${cellName}/packages;
#  debug = true;
#  inputs.inputs = { inherit (inputs) nixpkgs; };
#};
#scripts = {
#  src = cellsFrom + /${cellName}/scripts;
#  inputs.inputs = { makesSrc = inputs.std.inputs.makes; };
#};
#tasks = {
#  src = cellsFrom + /${cellName}/tasks;
#  inputs.inputs = { makesSrc = inputs.std.inputs.makes; };
#};
#} // _pops)
#
#
# --- HELPER LIBRARY ---------------------------------------
#
#configTypes = [ "devshell" "disko" "flake" "hardware" "homeManager" "nixondroid" "nixos" "nixvim" "robotnix" ];
#mkConfigTypes = t: {
#  "${t}Configurations" = {
#    src = cellsFrom + /${cellName}/${t}Configurations;
#  };
#  "${t}Modules" = {
#    src = cellsFrom + /${cellName}/${t}Modules;
#  };
#  "${t}Profiles" = {
#    src = cellsFrom + /${cellName}/${t}Profiles;
#  };
#};
