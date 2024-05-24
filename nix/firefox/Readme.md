# `//firefox`

Cell for Firefox packages and configurations.

## Goals

- Maximize code reuse between environments.
- Allow configuring Firefox outside of NixOS / home-manager / Darwin / system-manager
- Allow configuring Firefox inside of NixOS / home-manager / Darwin / system-manager
- Allow merging system & user Firefox configurations.
- Allow applying configurations to Flatpak versions of Firefox-based browsers.

## Cell Blocks

### `//firefox/packages`

[See here](./packages/Readme.md)

### `//firefox/homeProfiles`

Profiles:

- `base`: Basic profile for all other profiles to extend.
- `default`: Base profile + other settings overridden by other profiles.
- `gnome`: Profile for GNOME.
- `kde`: Profile for KDE Plasma.
- `hardened`: Profile with stricter settings and enhanced privacy/security protections.
- `relaxed`: Profile with less strict settings and loosen privacy/security protections. For fallback purposes.

- [ ] TODO: Figure out how to bundle all profiles into one package, then set default.

### `//firefox/nixosProfiles`

Like `//firefox/homeProfiles`, but with policies that apply system-wide.

### `//firefox/lib`

- [ ] TODO: `lib.firefox.mergeConfigs`
- [ ] TODO: `lib.firefox.mergePolicies`
- [ ] TODO: `lib.firefox.wrapFirefoxWithConfig`
- [ ] TODO: `lib.firefox.setDefaultProfile`?

### `//firefox/pops`

- [ ] TODO: `blockTypes.nvfetcher`
- [ ] TODO: Create exporter to convert `nixosProfiles.<profile>` to `nixosModules.profile-firefox-<profile>`
- [ ] TODO: Create exporter to convert `homeProfiles.<profile>` to `homeModules.profile-firefox-<profile>`
