{ inputs, config, lib, pkgs, ... }:
{
  imports = [ ];

  # --- Nix Path -----------------------
  # https://nixos.wiki/wiki/Flakes
  # Note: channels & nixPath are legacy, but still often used by tooling
  environment.etc = {
    "nix/inputs/nixpkgs".source = "${inputs.nixpkgs}"; #inputs.nixpkgs.outPath;
    #"nix/inputs/nixpkgs-stable".source   = inputs.nixpkgs-stable.outPath;
    #"nix/inputs/nixpkgs-unstable".source = inputs.nixpkgs-unstable.outPath;
    #"nix/inputs/nixpkgs-staging".source  = inputs.nixpkgs-staging.outPath;
    #"nix/inputs/nixpkgs-master".source   = inputs.nixpkgs-stable.outPath;

    "nix/inputs/nixos".source = "${inputs.nixos}"; #inputs.nixos.outPath;
    #"nix/inputs/nixos-stable".source     = inputs.nixos-stable.outPath;
    #"nix/inputs/nixos-unstable".source   = inputs.nixos-unstable.outPath;
    #"nix/inputs/nixos-staging".source    = inputs.nixos-staging.outPath;
    #"nix/inputs/nixos-master".source     = inputs.nixos-stable.outPath;
  };
  nix.nixPath = [ "/etc/nix/inputs" ];
}
