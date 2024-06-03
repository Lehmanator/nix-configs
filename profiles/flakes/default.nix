{ inputs, ... }:
let
  inherit (inputs.haumea.lib) load loaders matchers transformers;
  print-loader = inputs: path: toString path;
in
{
  imports = [
    # inputs.flake-parts.flakeModules.easyOverlay
    inputs.hercules-ci-effects.flakeModule
    inputs.nix-cargo-integration.flakeModule
    #inputs.process-compose-flake.flakeModule
    #inputs.proc-flake.flakeModule

    ./agenix-shell.nix
    #./devenv.nix
    ./devshell.nix
    #./disko
    #./easyOverlay.nix
    #./ez-configs.nix
    ./emanote.nix
    #./flake-parts-website.nix
    #./hercules-ci.nix
    #./nix-cargo-integration.nix
    #./nixid.nix
    ./nixpkgs-overlay.nix
    ./nixvim.nix
    ./pre-commit-hooks.nix
    #./process-compose-flake.nix
    #./proc-flake.nix
    ./treefmt.nix
    ../std
  ];

  #perSystem = { config, lib, pkgs, system, ... }:
  #  {
  #    #lib = load {
  #    #  src = ../../lib;
  #    #  loader =
  #    #};
  #  };
  #flake = {
  #  #lib = {
  #  #  loaders = {
  #  #    #callSources =
  #  #    #profileModule =
  #  #    #
  #  #  };
  #  #  matchers = {
  #  #    #defaultOnly =
  #  #    #excludeDefault =
  #  #  };
  #  #  transformers = {
  #  #    #prefix =
  #  #    #pathSeparator =
  #  #  };
  #  #};
  #  loaders = {
  #    path = load {
  #      src = ../nixvim;
  #      loader = loaders.path;
  #    };
  #    default = load {
  #      src = ../nixvim;
  #      loader = loaders.default;
  #    };
  #    scoped = load {
  #      src = ../nixvim;
  #      loader = loaders.scoped;
  #    };
  #    verbatim = load {
  #      src = ../nixvim;
  #      loader = loaders.verbatim;
  #    };
  #    print = load {
  #      src = ../nixvim;
  #      loader = print-loader;
  #    };
  #  };
  #};
}
