# To-Do: Packager Libs/Packages

1. `flatpak2nix` - Flatpaks
2. `snap2nix` - Ubuntu Snaps
3. `deb2nix` - Debian
4. `rpm2nix` - Fedora
5. `pkgbuild2nix` - Arch Linux
6. `apkbuild2nix` - Alpine

Find some way to allow packages to specify dependency version constraints,
like in Rust via `Cargo.toml` or Node.js via `package.json`.

Find some way to create development branch package variants for all packages in `nixpkgs`.

Existing Variants:

- `nodePackages` (current stable)
- `nodePackages_latest` (next stable?)
- `python311Packages` & `python312Packages`

- Automatically update revisions and hashes to latest from source repo on set schedule.
- Automatically test each package upon update, and find some mechanism to track:
  - Failures on each version/revision.
  - Last-known-working version/revision with respect to `<x>` package.
  - Last-known-working version/revision with respect to **all** packages.
  -
