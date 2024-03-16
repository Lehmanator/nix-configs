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

File: `../homeConfigurations.nix`

- Old:

  ```(nix)
  { inputs, cell, }@commonArgs:
  #let
  #  inherit (inputs.haumea.lib) load loaders matchers transformers;
  #in
  #  load {
  #    src = ./homeConfigurations;
  #    loader = loaders.verbatim;
  #    transformer = transformers.liftDefaults;
  #  }

  ```

- New:

  ```(nix)
  {inputs,cell}: cell.pops.homeConfigurations.exports.default
  ```

## Look into

- `mkHome` (omnibus)
