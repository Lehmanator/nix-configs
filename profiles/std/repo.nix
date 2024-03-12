{ inputs, ... }: {
  std = {
    # Harvest: Standard outputs into Nix-CLI-compatible form (aka 'official' flake schema)
    harvest = {
      devShells = [ [ "repo" "shells" ] ];
      nixago = [ [ "repo" "configs" ] ];
      #packages = [ [ "repo" "packages" ] ];
      nixpkgs = [ [ "repo" "pkgs" ] ];
    };

    # Pick: Like `harvest` but remove the system for outputs that are system agnostic.
    pick = {
      #nixago = [ [ "repo" "configs" ] ];
      devshellProfiles = [ [ "repo" "devshellProfiles" ] ];
      nixosProfiles = [ [ "repo" "nixosProfiles" ] ];
      shells = [ [ "repo" "shells" ] ];
      pops-repo = [ [ "repo" "pops" ] ];
    };
  };
}
