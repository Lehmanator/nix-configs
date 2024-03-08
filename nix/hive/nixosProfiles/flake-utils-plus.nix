{ inputs
, lib
, pkgs
, ...
}:
{
  imports = [ inputs.flake-utils-plus.nixosModules.autoGenFromInputs ];

  nix = {
    generateRegistryFromInputs = lib.mkDefault true;
    generateNixPathFromInputs = lib.mkDefault true;
    linkInputs = lib.mkDefault true;
  };
}
