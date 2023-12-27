# Questions about new Nix Flake Standard structure


1. What is the relationship between the following?:

- std
- hive
- paisano
- haumea
- 

2. Is this new schema going to have the ability to define the following between cells?:

- common  (shared config for all/subsets)
- default (common + small set of config to apply by default)


3. Are there any resources for learning? i.e.:
- Documentation
- Tutorials
- Example configs
- Dotfile repos (besides [dar/home-nix](https://gitlab.com/dar/hive-nix))

4. Is there going to be a way to define a network?

5. Is there going to be a way to define machines & their hardware?
- Alter profiles based on them  (e.g. gnome profile on laptop loads laptop-specific configuration for GNOME)

6. How can you add packages from other flakes?
- nixGL
- nixpkgs-wayland
- packages defined in flakes


