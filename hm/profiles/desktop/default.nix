{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    "${inputs.self}/hm/profiles/flatpak.nix"
    "${inputs.self}/hm/profiles/pipewire.nix"
    "${inputs.self}/hm/profiles/rofi.nix"
    "${inputs.self}/hm/profiles/zed.nix"
    "${inputs.self}/hm/profiles/wayland.nix"
    # "${inputs.self}/hm/profiles/polybar.nix"
    # "${inputs.self}/hm/profiles/udiskie.nix"

    "${inputs.self}/hm/profiles/desktop/fonts.nix"
    # "${inputs.self}/hm/profiles/desktop/fusuma.nix"
  ];
}
