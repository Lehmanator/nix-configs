{ inputs, cell, }@commonArgs:
inputs.omnibusStd.mkBlocks.pops commonArgs rec {
  packages = {
    src = ./packages/utils;
    inputs = { inherit cell inputs; };
  };

  nixosModules = { src = ./nixos/modules; };
  nixosProfiles = { src = ./nixos/profiles; };

  homeModules = { src = ./hm/modules; };
  homeProfiles = { src = ./hm/profiles; };
}
