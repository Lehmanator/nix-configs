# home-manager Configurations

## Examples

```(nix)
homeConfigurations = {
  sam = inputs.home.lib.homeManagerConfiguration {
    #pkgs = nixpkgs.legacyPackages.x86_64-linux;
    modules = [ ./hm/users/sam ];
    extraSpecialArgs = { inherit inputs; user = "sam"; };
  };
  guest = inputs.home.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #modules = [./hm/users/default];
    extraSpecialArgs = { inherit inputs; user = "guest"; };
  };
};
```

Note: *this snippet was originally found in `flake.nix`, but commented out for a while.
  It has been moved here to reduce clutter in `flake.nix`.
