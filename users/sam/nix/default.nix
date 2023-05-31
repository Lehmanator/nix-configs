{ self
, inputs
, overlays
, packages
, modules
, templates
, config
, lib
, pkgs
, ...
}:
# TODO: Write this config to       /etc/nix/nix.conf
# TODO: Write this config to  ~/.config/nix/nix.conf
# TODO: Write nix.registry to ~/.config/nix/registry.json
# TODO: Merge this config with equivalent from NixOS profile ( ${self}/profiles/nix.nix )
#let
#  inputPathSuffix = "nix/inputs";
#  inputPathBase = "${config.xdg.configHome}/${inputPathSuffix}";
#  getInputPathSuffix = k: "${inputPathSuffix}/${k}";
#  getInputPath = k: "${config.xdg.configHome}/${getInputPathSuffix k}";
#  getInputPathStr = k: "${k}=${getInputPath k}";
#  mkPath = inp: lib.attrsets.mapAttrsToList (k: v: "${k}=${config.xdg.configHome}/nix/inputs/${k}") inp;
#  mkInputConfig = inp: lib.attrsets.mapAttrsToList (k: v: k)
#in
with lib;
#let
#    filterInputs = attrsets.filterAttrs (k: v: (v.flake != false) && (v.flake != null));
#in
{
  imports = [
    ./utils.nix
  ];
  nix.package = mkDefault pkgs.nixUnstable; # Needed for use-xdg-base-directories

  # Import nixpkgs config & write to ~/.config/nixpkgs/config.nix so profiles use same config
  nixpkgs.config = import ./nixpkgs.nix;
  nix.settings   = import ./nix.nix;

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs.nix;

  #xdg.configFile = let mkInputConfigs = attrsets.mapAttrs' (k: v: [ "nix/inputs/${k}".source v.outPath ]);
  #in mkInputConfigs inputs // {
  #  "nixpkgs/config.nix".source = ./nixpkgs.nix;
  #       #"nix/nix.conf".source = ./nix.nix;
  #};

  #home.sessionVariables.NIX_PATH = (strings.concatStringsSep ":" (
  #  attrsets.mapAttrsToList (k: v: "${k}=${config.xdg.configHome}/nix/inputs/${k}") inputs
  #)) + "$\{NIX_PATH:+:$NIX_PATH}";

  #nix.registry = let
  #  filterInputs = attrsets.filterAttrs (k: v: (v.flake != false) && (v.flake != null));
  #  mkInputRegistry = i: attrsets.mapAttrs' (k: v: [ k.flake v ]) (filterInputs i);
  #in mkInputRegistry inputs;


  nix.registry.self.flake         = inputs.self;
  nix.registry.nixpkgs.flake      = inputs.nixpkgs;
  nix.registry.nixos.flake        = inputs.nixos;
  nix.registry.home-manager.flake = inputs.home;

  # TODO: Combine system / home-manager configs for: nix, nixpkgs, flake.nixConfig
  # TODO: Separate nix config to separate file like `nixpkgs.config`
  #nix.settings = import ./nix.nix;
  #xdg.configFile."nix/nix.conf".source = ./nix.nix;

  #xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs.nix;

  # Keep legacy nix-channels in sync w/ flake inputs (for tooling compat)
  # TODO: Same for NixOS, conditionally if system is NixOS
  xdg.configFile."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  xdg.configFile."nix/inputs/nixos".source = inputs.nixos.outPath;
  xdg.configFile."nix/inputs/home".source = inputs.home.outPath;

  #home.sessionVariables.NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";

}
