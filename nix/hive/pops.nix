{ inputs, cell, }@commonArgs:
let
  inherit (inputs) omnibusStd;# cellsFrom cellsFrom' _pops ;
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
  # TODO: Kubernetes, containers, tests, checks, jupyenv, nixago, secrets
in
omnibusStd.mkBlocks.pops commonArgs {
  configs = { src = ./configs; };

  devshellProfiles = { src = ./devshellProfiles; };
  shells = { src = ./shells; };

  diskoConfigurations = { src = ./diskoConfigurations; };
  diskoProfiles = { src = ./diskoProfiles; };

  homeConfigurations = { src = ./homeConfigurations; };
  homeProfiles = { src = ./homeProfiles; };
  homeModules = { src = ./homeModules; };
  homeSuites = { src = ./homeSuites; };

  nixosConfigurations = { src = ./nixosConfigurations; };
  nixosProfiles = { src = ./nixosProfiles; };
  nixosModules = { src = ./nixosModules; };
  nixosSuites = { src = ./nixosSuites; };

  nixvimConfigurations = { src = ./nixvimConfigurations; };
  nixvimProfiles = { src = ./nixvimProfiles; };
  nixvimModules = { src = ./nixvimModules; };
  nixvimSuites = { src = ./nixvimSuites; };

  lib = { src = ./lib; };
  packages = { src = ./packages; };
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
