{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    (inputs.self + /nixos/profiles/appimage.nix)
    (inputs.self + /nixos/profiles/containers)
    (inputs.self + /nixos/profiles/vm.nix)
    (inputs.self + /nixos/profiles/waydroid.nix)
    (inputs.self + /nixos/profiles/wine.nix)
  ];
}
