{ inputs, ... }: {
  std = {
    # Harvest: Standard outputs into Nix-CLI-compatible form (aka 'official' flake schema)
    harvest = {
      devShells = [ [ "repo" "shells" ] ];
      nixago = [ [ "repo" "configs" ] ];
      packages = [ [ "repo" "packages" ] ];
    };

    # Pick: Like `harvest` but remove the system for outputs that are system agnostic.
    pick = {
      devshellProfiles = [ [ "repo" "devshellProfiles" ] ];
      #pops = [ [ "repo" "pops" ] ];
      nixosProfiles = [ [ "repo" "nixosProfiles" ] ];
      shells = [ [ "repo" "shells" ] ];
    };
  };
}
