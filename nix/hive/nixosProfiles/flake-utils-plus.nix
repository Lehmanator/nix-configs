{ inputs, lib, pkgs, ... }: {
  imports = [ inputs.flake-utils-plus.nixosModules.autoGenFromInputs ];

  nix = {
    generateNixPathFromInputs = lib.mkDefault true;
    generateRegistryFromInputs = lib.mkDefault true;
    linkInputs = true;
  };
}
