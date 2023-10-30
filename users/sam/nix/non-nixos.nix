{ inputs, self, config, lib, pkgs, ... }:
{
  imports = [
  ];

  targets.genericLinux.enable = true;
  home.sessionVariables.NIX_PATH = "nixpkgs=${inputs.nixpkgs}";
  nixpkgs.overlays = [inputs.nur.overlay];
  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = ["nix-command" "flakes"];
    #registry.nixos.flake = inputs.nixos;
    #registry.darwin.flake = inputs.darwin;
    registry.nixpkgs = {
      flake = inputs.nixpkgs;
      from = {
        id = "nixpkgs";
        type = "indirect";
      };
    };
  };

  # zsh doesnt always load ~/.profile on other distros
  programs.zsh.envExtra = ''
    source "$HOME/.profile"
  '';

}
