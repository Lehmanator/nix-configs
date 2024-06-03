{ lib, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.gcr
    pkgs.gcr_4
    pkgs.adw-gtk3
    pkgs.gnome.adwaita-icon-theme
    pkgs.gnome.gnome-themes-extra
    pkgs.simp1e-cursors
    #pkgs.livecaptions # Build failing as of 1/15/24: failing dep=python3.11-onnx-1.15.0
    #pkgs.nur.repos.federicoschonborn.morewaita
  ];
  gtk.iconCache.enable = true;

  programs = {
    # GTK3 plugin to show popup to search menus of compatible apps
    plotinus.enable = lib.mkDefault true;
    sway.wrapperFeatures.gtk = lib.mkDefault true;

    # Use GTK4 pinentry
    #ssh.askPassword = "${pkgs.gcr_4}/libexec/gcr4-ssh-askpass";
  };

  # Allows gpg-agent & rbw to use pinentry-gnome3
  services.dbus.packages = [ pkgs.gcr pkgs.gcr_4 ];

  #services.xserver.displayManager.lightdm.greeters.gtk.enable = lib.mkDefault true;


}
