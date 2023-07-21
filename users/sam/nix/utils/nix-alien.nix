{ inputs, system
, config, lib, pkgs
, ...
}:
{
  home.packages = [ inputs.nix-alien.packages."${pkgs.stdenv.system}".nix-alien ];
  #programs.nix-ld.enable = true;  # NOTE: Only avail in NixOS config.
}

