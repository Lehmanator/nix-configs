# Hive: `homeConfigurations`

## Configurations

These are my main home-manager configurations.

## Specialisations

Define option `specialisation.<name>.configuration` for each item in `homeConfigurations`.
(or `homeProfiles.<profileName>`)

Usage:

```(bash)
$ home-manager generations | head -1
2022-05-02 22:49 : id 1758 -> /nix/store/jy…ac-home-manager-generation

/nix/store/jy…ac-home-manager-generation/specialisation/<name>/activate
Starting Home Manager activation
…
```

or (oneliner)

```(bash)
$ $(home-manager generations | head -1 | choose -1)/specialisation/<name>/activate
Starting Home Manager activation
…
```

See also:

- [nixosConfigurations/Readme.md](../nixosConfigurations/Readme.md)

### Desktop Environment

- `gnome`
- `gnome-mobile`
- `hyprland`
- `plasma`
- `xfce`

### Display Protocol

- `display-wayland`
- `display-wayland-only`
- `display-x11`
- `display-x11-only`
- `display-none` (terminal-only)

### Theme

- `theme-dark`
- `theme-light`
- `theme-auto` (auto light/dark mode, ANSI-compatible themes for CLI programs)

- [ ] TODO: Possible to use with `stylix`?

### Disable Modules

- `enable-module-<moduleName>`
- `disable-module-<moduleName>`

## Questions

- Options added by external `homeManagerModules` imports
  available under `specialisation.<name>.configuration`?
- Conditionally create specialisations using `lib.mkIf`?
- Conditionally import specialisations based on `osConfig`/`nixosConfig` module arg?
- Compose specialisations by merginge `specialisation.*.configuration` options?
  e.g.
  - `specialisations.gnome-light`
  - `specialisations.gnome-dark`
  - `specialisations.gnome-auto`
  - `specialisations.plasma-light`
  - `specialisations.plasma-dark`
  - `specialisations.plasma-auto`

## Look into

- `mkHome` (omnibus)

## Original Layout

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
