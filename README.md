# Nix / NixOS Configs

❄️  Welcome! ❄️

*What do we have here?*

- Work-in-progress set of NixOS configs.
- Extremely bloated `flake.nix` stuffed with every input flake repo I have ever come across.
- Many NixOS & home-manager profiles having varying degrees of maintainence.
- A couple of fully working NixOS configurations.
- A living document of my learning process with Nix and the many tragedies overcome.

There's probably a lot of useful stuff here. You'll have to dig through the rest to find it.

Right now, nothing is exported with intent of external use. Eventually, that will change.

I have been going back-and-forth between using several Nix libs to organize my stuff. Still haven't decided.
If you have any insight on these, lemme know:

- `snowfallorg/lib`
- `divnix/std` & `divnix/hive`
- `GTrunSec/omnibus`
- `numtide/flake-parts`


## Planned Additions

### Near-future

- Start adding secrets encrypted with `sops-nix`.
- Disko-ify my existing machines.
- Secure Boot on everything via `lanzaboote`.
- Ephemeral configs via `impermanence`.
- Custom NixOS installer with:
  - `experimental-features` enabled by default: `nix-command`, `flakes`, `recursive-nix`, `ca-derivations`.
  - Disko pre-loaded. devShell to select from `diskoConfigurations` & format disks before install.
  - Ready for full-disk-encryption & secure boot with resume from hibernate out of the box.

### Configuration Types

- `robotnixConfigurations`
- `nix-on-droid-Configurations`
- `openwrtConfigurations`
- `nixvimConfigurations`
- `diskoConfigurations`

### Infrastructure

- Kubernetes cluster from various machines.
- Migration of my Kubernetes manifests & Helm charts to Nix
- Netboot server & config images
- Binary cache & remote builders
- NUR repo & overlays
- Terranix configs

### Modules

- Flakify `NixOS/mobile-nixos`
- Genericize configuration options between Chromium & Firefox.
- LDAP directory trees as Nix config.

### Packages

- GNOME apps missing from `nixpkgs`

### Ideas n stuff

- `homeConfigurations` as a composition of `devShells`
- `nixvimConfigurations` but modularized like NixOS.
- `nixvimConfigurations` but for VSCode & Helix. Possibly a conversion util. Abstract away the editor.

