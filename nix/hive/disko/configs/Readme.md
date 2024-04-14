# Hive: `diskoConfigurations`

Moved from `flake.nix`:

```(nix)
  # --- Disko ---
  # TODO: [Disko UI](https://gist.github.com/Mic92/b5b592c0c33d720cb07a070cb8911588)
  # TODO: [Disko `nix run`](https://github.com/nix-community/disko/pull/78)
  #
  # Write disk by running command:
  #   `nix run .#nixosConfigurations.<host>.config.system.build.diskoNoDeps`
  # before running:
  #   `nixos-install --flake .#<host>`
  #
  #// inputs.flake-utils.lib.eachDefaultSystem (system:
  #let
  #  pkgs = nixpkgs.legacyPackages.${system};
  #  hosts = pkgs.lib.filterAttrs
  #    (_: value:
  #      value.pkgs.system == system &&
  #      builtins.hasAttr "diskoNoDeps" value.config.system.build
  #    )
  #    self.nixosConfigurations;
  #in
  #if (hosts == { }) then { } else {
  #  apps.disko = pkgs.lib.genAttrs (builtins.attrNames hosts) (name:
  #    {
  #      program = "${self.nixosConfigurations.${name}.config.system.build.diskoNoDeps}";
  #      type = "app";
  #    });
  #});

```
