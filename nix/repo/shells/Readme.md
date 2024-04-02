# Repo: `devShells`

Development shells to manage this Git repository.

## Shells

- `std`: Shell loading base `devshellProfile` from upstream `std` project

### To-Do: Shells

- `default`: Shell to load all basic `devshellProfiles`

## Profiles

- `git`
- `nix-base`: Base profile to work with Nix language & its projects.
- `std-base`: Base profile to work with `std`-based Nix projects.

### To-Do: Profiles

- `age`: Base profile to encrypt/decrypt/manage `age` secrets for repo.

  - [ ] Activate repo environment with decrypted `age` secrets

- `doc`: Base profile to build `mdBook`

  - [ ] Command to build `mdBook` w/ all `Readme.md` files collected from `std` dirs.
  - [ ] Command to run `mdBook` webserver.

- `fzf`: Base profile with `fzf` & `fzf`-related utils provided.
- `vim`: Base profile with `vim` & plugins provided.
- `vscode`: Base profile with `vscode` & plugins provided.
- `zsh`: Base profile with `zsh` & plugins provided.
