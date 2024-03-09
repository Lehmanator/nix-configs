{ inputs, cell, }@commonArgs:
let
  inherit (inputs) omnibusStd;# cellsFrom cellsFrom' _pops ;
  inherit (inputs.nixpkgs) lib;
  inherit (inputs.omnibus) pops;
  cellName = builtins.baseNameOf ./.;
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
  # TODO: Which pops are available in `mkBlocks`, omnibus, hivebus?
  #
  # mkBlocks: configs, data, devshellProfiles, jupyenv, packages, pops, scripts, shells, tasks
  #
  # TODO: Kubernetes, containers, tests, checks, jupyenv, nixago, secrets
in
lib.recursiveUpdate
  (omnibusStd.mkBlocks.pops commonArgs {
    configs = {
      src = ./configs;
      inputs = { inherit inputs cell; };
    };
    devshellProfiles = {
      src = ./devshellProfiles;
      inputs = { inherit inputs cell; };
    };
    packages = {
      src = ./packages;
      inputs = { inherit inputs cell; };
    };
    shells = {
      src = ./shells;
      inputs = { inherit inputs cell; };
    };

    homeModules = { src = ./homeModules; };
    homeProfiles = {
      src = ./homeProfiles;
      type = "nixosProfiles";
    };
    #homeSuites = { src = ./homeSuites; type = "nixosSuites"; };

    nixosModules = { src = ./nixosModules; };
    nixosProfiles = {
      src = ./nixosProfiles;
      type = "nixosProfiles";
    };
    #nixosSuites = { src = ./nixosSuites; type = "nixosProfilesOmnibus"; };

    lib = inputs.omnibus.pops.load {
      src = ./lib;
      loader = inputs.haumea.lib.loaders.default;
      inputs = { inherit inputs cell; };
    };
  })
{
  #}

  diskoConfigurations = {
    src = ./diskoConfigurations;
    inputs = { inherit inputs cell; };
  };
  diskoProfiles = {
    src = ./diskoProfiles;
    inputs = { inherit inputs cell; };
  };
  homeConfigurations = {
    src = ./homeConfigurations;
    inputs = { inherit inputs cell; };
  };
  #homeProfiles = {
  #  src = ./homeProfiles;
  #  inputs = { inherit inputs cell; };
  #};
  #homeModules = {
  #  src = ./homeModules;
  #  inputs = { inherit inputs cell; };
  #};
  #homeSuites = {
  #  src = ./homeSuites;
  #  inputs = { inherit inputs cell; };
  #};

  nixosConfigurations = {
    src = ./nixosConfigurations;
    inputs = { inherit inputs cell; };
  };

  nixvimConfigurations = {
    src = ./nixvimConfigurations;
    inputs = { inherit inputs cell; };
  };
  nixvimProfiles = {
    src = ./nixvimProfiles;
    inputs = { inherit inputs cell; };
  };
  nixvimModules = {
    src = ./nixvimModules;
    inputs = { inherit inputs cell; };
  };
  nixvimSuites = {
    src = ./nixvimSuites;
    inputs = { inherit inputs cell; };
  };
}
## Attr args should match that of Haumea load
#omnibusStd.mkBlocks.pops commonArgs ({
#configs = { src = cellsFrom + /${cellName}/configs; };
#containers = { src = cellsFrom + /${cellName}/configs; };
#data = { src = cellsFrom' + /${cellName}/data; };
#
##devshells = { src = cellsFrom + /${cellName}/devshellModules; };
##devshellModules = { src = cellsFrom + /${cellName}/devshellModules; };
#devshellProfiles = {
#  src = cellsFrom + /${cellName}/devshellProfiles;
#  inputs.inputs = { inherit (inputs.std.inputs) devshell; };
#};
#
##diskoConfigurations = { src = cellsFrom + /${cellName}/diskoConfigurations; };
##diskoModules = { src = cellsFrom + /${cellName}/diskoModules; };
##diskoProfiles = { src = cellsFrom + /${cellName}/diskoProfiles; };
#
##lib = { src = cellsFrom + /${cellName}/lib; };
#
##nixosConfigurations = { src = cellsFrom + /${cellName}/nixosConfigurations; };
##nixosModules = { src = cellsFrom + /${cellName}/nixosModules; };
##nixosProfiles = { src = cellsFrom + /${cellName}/nixosProfiles; };
#
##nixvimConfigurations = { src = cellsFrom + /${cellName}/nixvimConfigurations; };
##nixvimModules = { src = cellsFrom + /${cellName}/nixvimModules; };
##nixvimProfiles = { src = cellsFrom + /${cellName}/nixvimProfiles; };
#
#packages = {
#  src = cellsFrom + /${cellName}/packages;
#  debug = true;
#  inputs.inputs = { inherit (inputs) nixpkgs; };
#};
#pops = {
#  src = cellsFrom + /${cellName}/pops;
#
#  #robotnixConfigurations = { src = cellsFrom + /${cellName}/robotnixConfigurations; };
#  #robotnixModules = { src = cellsFrom + /${cellName}/robotnixModules; };
#  #robotnixProfiles = { src = cellsFrom + /${cellName}/robotnixProfiles; };
#
#  scripts = {
#    src = cellsFrom + /${cellName}/scripts;
#    inputs.inputs = { makesSrc = inputs.std.inputs.makes; };
#  };
#  shells = {
#    src = cellsFrom /${cellName}/shells;
#    tasks = {
#      src = cellsFrom + /${cellName}/tasks;
#      inputs.inputs = { makesSrc = inputs.std.inputs.makes; };
#    };
#  } // _pops)
