{ inputs
, overlays
, packages
, modules
, templates
, osConfig
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./access-tokens.nix
    ./cache.nix
    ./utils
    ./write-config.nix
    #./nix.nix
    #./nixpkgs.nix

  ];

  # TODO: Follow system, fallback to pkgs.nixUnstable
  nix = {
    package = lib.mkDefault pkgs.nixUnstable; # Needed for use-xdg-base-directories
    # TODO: Handle NixOS using system NIX_PATH when `home-manager.useGlobalPkgs=true`
    #nixPath = lib.mkDefault [ "${config.xdg.configHome}/nix/inputs" ];
  };

  # Keep legacy nix-channels in sync w/ flake inputs (for tooling compat)
  # TODO: Same for NixOS, conditionally if system is NixOS
  xdg.configFile = {
    #"nix/nix.conf".source           = ./nix.nix;
    #"nix/registry.json".source      = ./registry.json;
    #"nixpkgs/config.nix".source     = ./nixpkgs.nix;
    "nix/inputs/home".source = "${inputs.home}"; #.outPath;
    "nix/inputs/home-manager".source = "${inputs.home}"; #.outPath;
    "nix/inputs/nixpkgs".source = "${inputs.nixpkgs}"; #.outPath; # osConfig.environment.etc."nix/inputs/nixpkgs";
    "nix/inputs/nixos".source = "${inputs.nixos}"; #.outPath; # osConfig.environment.etc."nix/inputs/nixos";
    "nix/inputs/self".source = "${inputs.self}"; #.outPath;
    "nix/inputs/nixos-config".source = "${inputs.self}"; #.outPath;
    "nix/inputs/home-config".source = "${inputs.self}"; #.outPath;
  };
}

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
#with lib;
#let
#    filterInputs = attrsets.filterAttrs (k: v: (v.flake != false) && (v.flake != null));
#in

#home.sessionVariables = {
#  NIX_PATH = "nixpkgs=${config.xdg.configHome}/nix/inputs/nixpkgs$\{NIX_PATH:+:$NIX_PATH}";
#};

# Import nixpkgs config & write to ~/.config/nixpkgs/config.nix so profiles use same config
#nixpkgs.config = import ./nixpkgs.nix;
#nix.settings = import ./nix.nix;


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


#nix.registry = with inputs; {
#  self.flake         = self;
#  nixpkgs.flake      = nixpkgs;
#  nixos.flake        = nixos;
#  home-manager.flake = home;
#  home.flake         = home;
#};

# TODO: Combine system / home-manager configs for: nix, nixpkgs, flake.nixConfig
# TODO: Separate nix config to separate file like `nixpkgs.config`
#nix.settings = import ./nix.nix;
#xdg.configFile."nix/nix.conf".source = ./nix.nix;

#xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs.nix;

