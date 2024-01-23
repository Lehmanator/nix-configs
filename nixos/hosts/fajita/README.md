# Fajita - OnePlus 6T

## Build Instructions

```(nix)

nix build .#nixosConfigurations.fajita.config.mobile.outputs.android-fastboot-images

```

## Notes

## To-Do

- [ ] Enable Secure Boot
  - [ ] Add LUKS encryption
  - [ ] Add `pkgs.unl0kr` to initrd

- [ ] Upstream package updates
  - [ ] `pkgs.gnome.gnome-shell`
  - [ ] `pkgs.gnome.mutter`

