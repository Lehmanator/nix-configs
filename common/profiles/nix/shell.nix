{ config, lib, pkgs, ... }: {
  # home.shellAliases = {
  environment.shellAliases = {
    n = "nix";
    n-build = "nix build";
    nb = "nix build";
    build = "nix build";
    n-conf = "nix show-config";
    n-develop = "nix develop";
    develop = "nix develop";
    n-eval = "nix eval";
    neval = "nix eval";
    n-profile = "nix profile";
    profile = "nix profile";
    n-realization = "nix realisation";
    realization = "nix realisation";
    n-registry = "nix registry";
    registry = "nix registry";
    n-repl = "nix repl";
    repl = "nix repl";
    n-run = "nix run";
    run = "nix} run";
    nr = "nix run";
    n-search = "nix search";
    nixpkgs = "nix search nixpkgs";
    n-store = "nix store";
    store = "nix store";
  };
}
