{
  self, 
  modulesPath,
  system,
  inputs, outputs,
  config, lib, pkgs,
  ...
}:
let
  cfg = config.services.xserver;
in
{
  imports = [
    #inputs.nix-software-center.packages.${system}.nix-software-center
    #inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
    #inputs.snow.packages.${system}.snow

    ./gtk.nix

    #./gnome-admin.nix
    #./gnome-dev.nix

    #./gnome-edit-audio.nix
    #./gnome-edit-images.nix
    #./gnome-edit-video.nix

    #./gnome-emu-android.nix
    #./gnome-emu-windows.nix

    #./gnome-games.nix

    #./gnome-mobile.nix

    #./gnome-chat.nix
    #./gnome-social.nix

    #./gnome-view-audio.nix
    #./gnome-view-images.nix
    #./gnome-view-video.nix
  ];

  home.packages = with pkgs; [
    gnome.dconf-editor
    gnome.devhelp
    gnome.ghex
    #gnome.simple-scan
    gnome.totem
    gnome.vinagre
    gnome.zenity

    gnome.gnome-autoar
    gnome.gnome-boxes
    gnome.gnome-dictionary
    gnome.gnome-packagekit
    gnome.gnome-sound-recorder
    gnome.gnome-tweaks

    gnome-builder
    gnome-connections
    #gnome-decoder
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
  ];

  services.gnome-keyring.enable = true;
  services.gnome-keyring.components = [ "pkcs11" "secrets" "ssh" ];

  # https://gist.github.com/quidome/4e225db4b1611a9624d3927919f96bc6
  #config = lib.mkIf (cfg.desktopManager.gnome.enable == true) {
  #  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  '';
  #};
}
