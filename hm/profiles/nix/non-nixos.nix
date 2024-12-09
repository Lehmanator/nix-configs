{ inputs, config, lib, pkgs, osConfig, ... }:
let
  isNixOS = lib.mkIf (lib.hasAttrsByPath ["environment" "systemPackages"] osConfig);
in
{
  targets.genericLinux.enable = isNixOS true;
  home.sessionVariables.NIX_PATH = isNixOS "nixpkgs=${inputs.nixpkgs}";
  nixpkgs.overlays = isNixOS [ inputs.nur.overlays.default ];
  nix = isNixOS {
    # package = pkgs.nixVersions.latest;
    package = pkgs.lix;
    settings.experimental-features = isNixOS [ "nix-command" "flakes" ];
    #registry.nixos.flake = inputs.nixos;
    #registry.darwin.flake = inputs.darwin;
    registry.nixpkgs = isNixOS {
      flake = inputs.nixpkgs;
      from = {
        id = "nixpkgs";
        type = "indirect";
      };
    };
  };

  # zsh doesnt always load ~/.profile on other distros
  programs.zsh.envExtra = isNixOS ''
    source "$HOME/.profile"
  '';

}
