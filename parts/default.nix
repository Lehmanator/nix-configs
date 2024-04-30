{ inputs, flakeModule, omnibusStd, self, std, stdPop, systems, ... }@args:
inputs.omnibus.flake.inputs.flake-parts.lib.mkFlake { inherit inputs self; } {
  inherit systems;
  debug = true;
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
    #./easyOverlay.nix
    #./ez-configs.nix
    ./emanote.nix
    #./flake-parts-website.nix
    #./hercules-ci.nix
    #./nix-cargo-integration.nix
    #./nixid.nix
    ./pre-commit-hooks.nix
    #./process-compose-flake.nix
    #./proc-flake.nix
    #./std.nix
    ./treefmt.nix
  ];
  perSystem = { config, lib, pkgs, system, final, ... }: {
    packages = {
      inherit (inputs.disko.packages.${system}) disko disko-doc;
      deploy =
        inputs.nixpkgs.legacyPackages.${system}.writeText "cachix-deploy.json"
          (builtins.toJSON {
            agents = inputs.nixpkgs.lib.mapAttrs
              (host: cfg: cfg.config.system.build.toplevel)
              (inputs.nixpkgs.lib.filterAttrs
                (host: cfg:
                  cfg ? config && cfg.config ? system && cfg.config.system ? build
                  && cfg.config.system.build ? toplevel
                  && cfg.pkgs.stdenv.buildPlatform.system == system
                  && cfg.config.services.cachix-agent.enable)
                self.nixosConfigurations);
          });
    };
  };
  flake =
    let
      mkSystem =
        { host
        , system ? "x86_64-linux"
        , user ? "sam"
        , # specialArgs ? {},
          modules ? [ ]
        , ...
        }@args:
        (import "${inputs.self}/lib/flake/lehmanatorSystem.nix" {
          inherit inputs self;
        }) {
          inherit system;
          specialArgs = {
            inherit inputs user;
            # Instantiate all instances of nixpkgs in flake.nix to avoid creating new nixpkgs instances
            # for every `import nixpkgs` call within submodules/subflakes. Saves time & RAM.
            #  - https://nixos-and-flakes.thiscute.world/nixos-with-flakes/downgrade-or-upgrade-packages
            #  - https://nixos-and-flakes.thiscute.world/nixpkgs/multiple-nixpkgs
            pkgs-stable = import inputs.nixpkgs-stable {
              inherit system;
              config.allowUnfree = true;
            };
            pkgs-unstable = import inputs.nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            pkgs-master = import inputs.nixpkgs-master {
              inherit system;
              config.allowUnfree = true;
            };
            pkgs-staging = import inputs.nixpkgs-staging {
              inherit system;
              config.allowUnfree = true;
            };
            pkgs-staging-next = import inputs.nixpkgs-staging-next {
              inherit system;
              config.allowUnfree = true;
            };
          };
          modules = [ (inputs.self + /nixos/hosts/${host}) ] ++ modules;
        };
    in
    {
      inherit flakeModule omnibusStd std stdPop systems;
      overlays = import (inputs.self + /nixos/overlays);
      nixosConfigurations = {
        fw = mkSystem { host = "fw"; };
        wyse = mkSystem { host = "wyse"; };
        fajita = inputs.nixos.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs;
            user = "sam";
          };
          modules = [
            {
              _module.args = {
                inherit inputs;
                user = "sam";
              };
            }
            (import "${inputs.mobile-nixos}/lib/configuration.nix" {
              device = "oneplus-fajita";
            })
            (inputs.self + /nixos/hosts/fajita)
            inputs.nixpkgs-gnome-mobile.nixosModules.gnome-mobile
          ];
        };
        fajita-minimal = inputs.nixos.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs;
            user = "sam";
          };
          modules = [
            {
              _module.args = {
                inherit inputs;
                user = "sam";
              };
            }
            (import "${inputs.mobile-nixos}/lib/configuration.nix" {
              device = "oneplus-fajita";
            })
            (inputs.self + /nixos/hosts/fajita/minimal.nix)
            inputs.nixpkgs-gnome-mobile.nixosModules.gnome-mobile
          ];
        };
      };
    };
}
