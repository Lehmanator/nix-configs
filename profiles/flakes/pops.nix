{inputs, ... }:
let
  inherit (inputs.omnibus) pops;
  inherit (pops) nixosModules nixosProfiles homeModules homeProfiles;
in
{
  perSystem = {config, lib, pkgs, system, ...}:
  {
  };
  flake = {
    pops = {

      nixosModules = nixosModules.addLoadExtender {
        load = {
          src = ../../modules/nixos;
        };
      };
      nixosProfiles = nixosProfiles.addLoadExtender {
        load = {
          src = ../../profiles/nixos;
          inputs = {inherit inputs;};
        };
      };

      homeModules = homeProfiles.addLoadExtender {
        load = {
          src = ../../modules/hm;
          inputs = {inherit inputs;};
        };
      };
      homeProfiles = homeProfiles.addLoadExtender {
        load = {
          src = ../../profiles/hm;
          inputs = {inherit inputs;};
        };
      };

      #omnibus = forAllSystems (system:
      #  inputs.omnibus.pops.self.addLoadExtender {
      #    load.inputs = {
      #      inputs = {
      #        nixpkgs = inputs.nixpkgs.legacyPackages.${system};
      #      };
      #    };
      #  }
      #);

    };
  };
}
