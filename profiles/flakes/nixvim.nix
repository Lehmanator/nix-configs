{inputs, ...}: let
  #mkNixvim = inputs.nixvim.lib
  inherit (inputs.haumea.lib) load loaders matchers transformers;
  # Wrap profile "module" with enable option
  #profile-wrapper = p: {inputs, config, lib, pkgs, ...}@args: let
  #  cfg = config.profile-${path};
  #  pcfg = (p args);
  #in {
  #  imports = pcfg.imports;
  #  options.profile-${path} = pcfg.options // {
  #    enable = lib.mkEnableOption "profile-${path}";
  #  };
  #  config = lib.mkIf cfg.enable (pcfg.config // builtins.removeAttrs pcfg ["imports" "options" "config"]);
  #};
in {
  perSystem = {
    config,
    pkgs,
    system,
    inputs',
    ...
  }: let
    nixvimModule = {
      inherit pkgs;
      module =
        inputs.self.nixvimSuites.base; # import ../../nix/hive/nixvim/suites/base.nix;
      extraSpecialArgs = {inherit inputs;};
    };
  in {
    checks = {
      #nixvim = inputs'.nixvim.lib.check.mkTestDerivationFromNixvimModule nixvimModule;
      nixvim =
        inputs.nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule
        nixvimModule;
    };
    packages = {
      nvim = inputs'.nixvim.legacyPackages.makeNixvimWithModule nixvimModule;
    };
  };

  #flake = {
  #  #lib = {
  #  #  mkNixvim = inputs'.nixvim.legacyPackages.makeNixvimWithModule nixvimModule;
  #  #matchers.ignore-default = ext: f: {
  #  #  matches = file: !(inputs.nixpkgs.lib.hasSuffix "default.${ext}") && inputs.nixpkgs.lib.hasSuffix ".${ext}" file && inputs.nixpkgs.lib.stringLength file > (inputs.nixpkgs.lib.stringLength ext + 1);
  #  #  loader = f;
  #  #};
  #  #};
  #  nvimProfiles = {
  #    default = ../nixvim;
  #    languages = load {
  #      src = ../nixvim/langs;
  #      loader = loaders.verbatim;
  #      #matcher = inputs.haumea.lib.matchers.nix;
  #    };
  #    plugins = load {
  #      src = ../nixvim/plugins;
  #      loader = loaders.verbatim;
  #    };
  #    colorschemes = load {
  #      src = ../nixvim/colorschemes;
  #      loader = loaders.verbatim;
  #    };
  #  };
  #  nvimModules = {
  #    default = ../nixvim;
  #    #profile-default = inputs.self.nixvimProfiles.default;
  #    #builtins.attrNames inputs.self.nixvimProfiles
  #  };
  #};
}
