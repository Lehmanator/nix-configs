{ inputs
, config
, lib
, pkgs
, ...
}:
{
  #nixpkgs.overlays = [inputs.nix-alien.overlays.default];
  home.packages = [
    #inputs.nix-alien.packages.${pkgs.system}.nix-alien
    #pkgs.nix-alien
  ];
  #programs.nix-ld.enable = true;  # NOTE: Only avail in NixOS config.
}

