{
  self,
  system,
  modulesPath,
  inputs, outputs,
  config, lib, pkgs,
  ...
}:
let

in 
{
  imports = [
    ./browsers.nix
    ./editor-neovim.nix
    ./gnome.nix
    ./shell-zsh.nix
  ];

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nur.overlay
  ];
  home.stateVersion = "23.05";
  home.enableNixpkgsReleaseCheck = true;

  home.packages = with pkgs; [
    gnome.dconf-editor
    gnome.gnome-autoar
    gnome.gnome-dictionary
    gnome.gnome-packagekit
    gnome.gnome-sound-recorder
    gnome.gnome-tweaks
    gnome.ghex
    gnome.simple-scan
    gnome.totem
    gnome.vinagre
    gnome.zenity
    gnome-builder
    gnome-connections
    gnome-doc-utils
    gnome-epub-thumbnailer
    gnome-extension-manager
    gnome-firmware
    gnome-frog
    gnome-keysign
    gnome-multi-writer
    gnome-podcasts
    gnome-obfuscate
    gnome-recipes
    gnome-secrets

    clapper
    gotktrix
    gtkcord4
    fractal-next
    headlines
    megapixels
    newsflash

    bitwarden
    cmatrix
  ];

  programs.home-manager.enable = true;

}
