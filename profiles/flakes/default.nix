{
  inputs,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.hercules-ci-effects.flakeModule
    inputs.nix-cargo-integration.flakeModule
    #inputs.process-compose-flake.flakeModule
    #inputs.proc-flake.flakeModule
    #inputs.std.flakeModule

    ./agenix-shell.nix
    #./devenv.nix
    ./devshell.nix
    ./disko
    #./easyOverlay.nix
    #./ez-configs.nix
    ./emanote.nix
    #./flake-parts-website.nix
    #./hercules-ci.nix
    #./nix-cargo-integration.nix
    #./nixid.nix
    ./nixos
    ./nixvim.nix
    ./pre-commit-hooks.nix
    #./process-compose-flake.nix
    #./proc-flake.nix
    #./std.nix
    ./treefmt.nix
  ];

  perSystem = {config, lib, pkgs, system, ...}:
  let
    inherit (inputs.haumea.lib) load;
  in
  {
    #lib = load {
    #  src = ../../lib;
    #  loader =
    #};
  };
  flake = {
  };
}
