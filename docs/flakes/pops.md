# POPs

Uses:

- [divnix/std](https://github.com/divnix/std)
- [divnix/hive](https://github.com/divnix/hive)
- [divnix/flops](https://github.com/divnix/flops)
- [tao3k/omnibus](https://github.com/tao3k/omnibus)


## Examples / Snippets

Follows `examples/stdStandard` from [tao3k/omnibus-examples](https://github.com/tao3k/omnibus-examples):

```(nix)
outputs = { self, omnibus, nixpkgs, ... }@inputs: {

  # ... rest of flake outputs ...

  pops = with inputs.omnibus.pops; {
    nixosModules = nixosModules.addLoadExtender {
      load = {
        src = ./nixos/modules;
      };
    };
    nixosProfiles = nixosProfiles.addLoadExtender {
      load = {
        src = ./nixos/profiles;
        inputs = {inherit inputs;};
      };
    };
    homeModules = homeProfiles.addLoadExtender {
      load = {
        src = ./hm/modules;
        inputs = {inherit inputs;};
      };
    };
    homeProfiles = homeProfiles.addLoadExtender {
      load = {
        src = ./hm/profiles;
        inputs = {inherit inputs;};
      };
    };

    # Configures Omnibus pop
    #omnibus = forAllSystems (system:
    #  inputs.omnibus.pops.self.addLoadExtender {
    #    load.inputs = { inputs = {nixpkgs = inputs.nixpkgs.legacyPackages.${system};}; };
    #});
    omnibus = self.addLoadExtender {
      load.inputs = {
        inputs = {
          inherit (inputs) nixpkgs;
          # nixpkgs = inputs.nixpkgs.legacyPackages.${system};
        };
      };
    };
  };
};

```

Note: this snippet was originally in `flake.nix`,
  but commented out for a while and has been moved here to reduce cluttering `flake.nix`

## To-Dos

- [x] Create repo for my custom POPs. [Lehmanator/nix-pops](https://github.com/Lehmanator/nix-pops)
- [ ] Use my custom POPs repo here & refactor.
