{ self, inputs,
  overlays, packages, modules, templates,
  config, lib, pkgs,
  ...
}:
{
  imports = [
  ];

  # Keep legacy nix-channels in sync w/ flake inputs (for tooling compat)
  # TODO: Same for NixOS, conditionally if system is NixOS
  xdg.configFile."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  home.sessionVariables.NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";

  nix.registry.nixpkgs.flake = inputs.nixpkgs;

}
