{ inputs, ... }: {
  std = {
    # Harvest: Standard outputs into Nix-CLI-compatible form (aka 'official' flake schema)
    harvest = {
      devShells = [ [ "kube" "shells" ] ];
      packages = [ [ "kube" "packages" ] ];
    };

    # Pick: Like `harvest` but remove the system for outputs that are system agnostic.
    pick = {
      devshellProfiles = [ [ "kube" "devshellProfiles" ] ];
      nixosModules = [ [ "kube" "nixosModules" ] ];
      nixosProfiles = [ [ "kube" "nixosProfiles" ] ];
      #nixosSuites = [ [ "kube" "nixosSuites" ] ];
      shells = [ [ "kube" "shells" ] ];

      pops-kube = [ [ "kube" "pops" ] ];
    };
  };
}
