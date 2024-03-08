# Hive: `homeConfigurations`

Originally in `flake.nix` (commented out)
Unrelated to `std`, `hive`, `omnibus`, & `hivebus`.
Putting here just so I don't forget about it.

```(nix)
homeConfigurations = {
  sam = inputs.home.lib.homeManagerConfiguration {
    #pkgs = nixpkgs.legacyPackages.x86_64-linux;
    modules = [ ./users/sam ];
    extraSpecialArgs = { inherit inputs; user = "sam"; };
  };
  guest = inputs.home.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    #modules = [./users/default];
    extraSpecialArgs = { inherit inputs; user = "guest"; };
  };
};
```
