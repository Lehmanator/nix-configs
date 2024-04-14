{
  inputs,
  cell,
} @ commonArgs: let
  inherit (inputs) omnibus omnibusStd cellsFrom cellsFrom' _pops;
  # TODO: Kubernetes, containers, tests, checks, jupyenv, nixago, secrets
  # TODO: Try: `src = cellsFrom + /${cellName}/packages;`
  cellName = builtins.baseNameOf ./.;
  # mkBlocks.pops:
  #   configs, data, jupyenv, packages, pops, scripts, tasks
  #         shells, devshellProfiles,
  #    homeModules,     homeProfiles,
  #   nixosModules,    nixosProfiles,
  # pops: (mkBlocks.pops ++ [)
  #   allData, example, hive, load, microvms, overlays, srvos, std,
  #     darwinModules, darwinProfiles,
  #   devshellModules,
  #   flake-parts.module, flake-parts.profile, flake
  #   systemManagerProfiles,
in
  with inputs.omnibus.pops;
    (omnibusStd.mkBlocks.pops commonArgs
      {
        #{
        configs = {src = ./configs;};
        data = {src = ./data;};
        jupyenv = {src = ./jupyenv;};
        #packages = {src = ./packages;};
        #packages = inputs.omnibus.pops.packages {
        #  src = ./packages;
        #  inputs = {
        #    inherit cell;
        #    inputs = {inherit (inputs) nixpkgs;};
        #  };
        #};
        #pops = {src = ./pops;};
        scripts = {
          src = ./scripts;
          inputs.inputs = {makesSrc = inputs.std.inputs.makes;};
        };
        tasks = {
          src = ./tasks;
          inputs.inputs = {makesSrc = inputs.std.inputs.makes;};
        };

        # --- DevShells -------------------------------------------
        shells = {src = ./devshells/configs;};
        devshellProfiles = {
          src = ./devshell/profiles;
          inputs.inputs = {inherit (inputs.std.inputs) devshell;};
        };

        # --- Home Manager -------------------------------------------
        homeModules = {src = ./home/modules;};
        homeProfiles = {
          src = ./home/profiles;
          transformer = [
            inputs.haumea.lib.transformers.liftDefault
            inputs.omnibus.lib.haumea.removeTopDefault
          ];
        };
        # --- NixOS --------------------------------------------------
        nixosModules = {src = ./nixos/modules;};
        nixosProfiles = {src = ./nixos/profiles;};

        # --- Hive ---------------------------------------------
        #hive = pops.hive; #. { src = ./hosts; };
        #hive = pops.hive.addLoadExtender { load = { src = ./hosts; }; };
      }
      or {})
    // {
      packages = inputs.omnibus.pops.packages {
        load = {
          src = ./packages;
          inputs = {inherit (inputs) nixpkgs;};
        };
      };
      # --- Darwin ----------------------------------------------
      darwinConfigurations = load {
        src = ./darwin/configs;
        type = "evalModules";
      };
      darwinModules =
        darwinModules.addLoadExtender {load.src = ./darwin/modules;};
      darwinProfiles =
        darwinProfiles.addLoadExtender {load.src = ./darwin/profiles;};
      darwinSuites = darwinProfiles.addLoadExtender {load.src = ./darwin/suites;};
      # --- DevShells -------------------------------------------
      devshellModules =
        devshellModules.addLoadExtender {load.src = ./devshell/modules;};
      devshellSuites =
        devshellProfiles.addLoadExtender {load.src = ./devshell/suites;};

      # --- Disko -------------------------------------------
      diskoConfigurations =
        nixosProfiles.addLoadExtender {load.src = ./disko/configs;};
      diskoProfiles =
        nixosProfiles.addLoadExtender {load.src = ./disko/profiles;};
      diskoSuites = nixosProfiles.addLoadExtender {load.src = ./disko/suites;};

      # --- flake-parts -------------------------------------
      #flakeConfigurations = flakes.addLoadExtender {load.src = ./flake/configs;};
      #flakeModules = flake-parts.modules.addLoadExtender {load.src = ./flake/modules;};
      #flakeProfiles = flake-parts.profiles.addLoadExtender {load.src = ./flake/profiles;};

      # --- Hardware -------------------------------------------
      #hardwareConfigurations = load { src=./hardware/configs; type="evalModules";};
      hardwareModules =
        nixosModules.addLoadExtender {load.src = ./hardware/modules;};
      hardwareProfiles =
        nixosProfiles.addLoadExtender {load.src = ./hardware/profiles;};
      hardwareSuites =
        nixosProfiles.addLoadExtender {load.src = ./hardware/suites;};

      # --- Home Manager -------------------------------------------
      #hive = hive.addLoadExtender {load.src = ./hive;};
      #homeConfigurations = load {
      #  #homeConfigurations = nixosProfiles.addLoadExtender {
      #  #homeConfigurations = homeProfiles.addLoadExtender {
      #  #  load = {
      #  src = ./home/configs;
      #  #type = "nixosProfiles";
      #  #loader = [ inputs.haumea.lib.matchers.nix inputs.haumea.lib.loaders.scoped ];
      #  transformer = inputs.haumea.lib.transformers.liftDefault;
      #  inputs = { inherit inputs cell; };
      #  #};
      #};
      homeSuites = homeProfiles.addLoadExtender {load.src = ./home/suites;};
      userProfiles = nixosProfiles.addLoadExtender {load.src = ./userProfiles;};
      # --- NixOS -------------------------------------------
      nixosConfigurations = {src = ./nixos/configs;};
      nixosSuites = nixosProfiles.addLoadExtender {load.src = ./nixos/suites;};
      # --- Nixvim -------------------------------------------
      nixvimConfigurations = load {
        src = ./nixvim/configs;
        type = "evalModules";
      };
      nixvimProfiles =
        nixosProfiles.addLoadExtender {load.src = ./nixvim/profiles;};
      nixvimModules = nixosModules.addLoadExtender {load.src = ./nixvim/modules;};
      nixvimSuites = nixosProfiles.addLoadExtender {load.src = ./nixvim/suites;};
      # --- Robotnix -----------------------------------------
      robotnixConfigurations = load {
        src = ./robotnix/configs;
        type = "evalModules";
      };
      robotnixModules =
        nixosModules.addLoadExtender {load.src = ./robotnix/modules;};
      robotnixProfiles =
        nixosProfiles.addLoadExtender {load.src = ./robotnix/profiles;};
      robotnixSuites =
        nixosProfiles.addLoadExtender {load.src = ./robotnix/suites;};
      # --- System-Manager -----------------------------------
      #systemManagerConfigurations = load { src = ./systemManager/configs; type="evalModules"; };
      #systemManagerModules = nixosModules.addLoadExtender {load.src = ./systemManager/modules;};
      #systemManagerProfiles = systemManagerProfiles.addLoadExtender {load.src = ./systemManager/profiles;};
      #systemManagerSuites = systemManagerProfiles.addLoadExtender {load.src = ./systemManager/suites;};
      # --- WSL ----------------------------------------------
      #wslConfigurations = load { src = ./wsl/configs; type="evalModules"; };
      #wslModules = nixosModules.addLoadExtender {load.src = ./wsl/modules;};
      #wslProfiles = nixosProfiles.addLoadExtender {load.src = ./wsl/profiles;};
      #wslSuites = nixosProfiles.addLoadExtender {load.src = ./wsl/suites;};

      lib = load {
        src = ./lib;
        loader = inputs.haumea.lib.loaders.default;
        inputs = {
          inherit inputs cell;
          #inherit (inputs.nixpkgs) lib;
          #pkgs = inputs.nixpkgs;
        };
      };
      #overlays = overlays.addLoadExtender {load.src = ./overlays;};
    }
#
## Attr args should match that of Haumea load
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
