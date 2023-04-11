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

    ../gtk.nix

    #./admin.nix
    #./dev.nix

    #./edit-audio.nix
    #./edit-images.nix
    #./edit-video.nix

    #./emu-android.nix
    #./emu-windows.nix

    #./games.nix

    #./mobile.nix

    #./chat.nix
    ./social.nix

    #./view-audio.nix
    #./view-images.nix
    #./view-video.nix

    #./apps
  ];

  home.packages = with pkgs; [
    gnome.dconf-editor
    gnome.devhelp
    gnome.ghex
    gnome.simple-scan
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
    gnome-firmware
    gnome-frog
    gnome-keysign
    gnome-multi-writer
    gnome-podcasts
    gnome-obfuscate
    gnome-recipes
    gnome-secrets

    clapper
    endeavour
    megapixels
    newsflash
  ];

  programs.rbw.settings.pinentry = "gnome3";

  qt.platformTheme = "gnome";
  qt.style.package = pkgs.adwaita-qt;
  #qt.style.name = "adwaita-dark";

  services.gnome-keyring.enable = true;
  services.gnome-keyring.components = [ "pkcs11" "secrets" "ssh" ];

  services.gpg-agent.pinentryFlavor = "gnome3";

  # Dunst: Notification Daemon
  services.dunst.iconTheme.name = "Adwaita";
  services.dunst.iconTheme.package = pkgs.adwaita-icon-theme;


  # https://gist.github.com/quidome/4e225db4b1611a9624d3927919f96bc6
  #config = lib.mkIf (cfg.desktopManager.gnome.enable == true) {
  #  services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #  '';
  #};

  #xdg.mimeApps.defaultApplications = {
  #  "text/html" = [ "org.gnome.Epiphany.desktop" ];
  #  "x-scheme-handler/https" = ["org.gnome.Epiphany.desktop"];
  #  "x-scheme-handler/mailto" = ["org.gnome.Evolution.desktop"];
  #};
}
