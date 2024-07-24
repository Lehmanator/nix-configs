{ config, lib, pkgs, user, ... }: {
  # Default settings for GTK-based desktops

  environment.systemPackages = [
    #pkgs.livecaptions # Build failing as of 1/15/24: failing dep=python3.11-onnx-1.15.0
    pkgs.plotinus
    pkgs.gcr
    pkgs.gcr_4
    pkgs.adw-gtk3
    # pkgs.adwaita-icon-theme
    # pkgs.gnome-themes-extra
    pkgs.gnome.adwaita-icon-theme
    pkgs.gnome-themes-extra
    pkgs.simp1e-cursors
    #pkgs.nur.repos.federicoschonborn.morewaita
  ];
  gtk.iconCache.enable = true;

  # GTK3 plugin to show popup to search compatible application's menus
  #programs.plotinus.enable = true; #lib.mkDefault true;
  #environment.sessionVariables.GTK3_MODULES = ["${pkgs.plotinus}/lib/libplotinus.so"];
  programs.sway.wrapperFeatures.gtk = true;
  #services.xserver.displayManager.lightdm.greeters.gtk.enable = lib.mkDefault true;
  services.dbus.packages = [
    pkgs.gcr # Allows gpg-agent & rbw to use pinentry-gnome3
    pkgs.gcr_4
  ];
  # Use GTK4 pinentry
  #programs.ssh.askPassword = "${pkgs.gcr_4}/libexec/gcr4-ssh-askpass";
}

#(lib.optionalAttrs (options?services.flatpak.packages) {
#  services.flatpak.packages = [
#    "org.gtk.Gtk3theme.Adwaita-dark" "org.gtk.Gtk3theme.adw-gtk3" "org.gtk.Gtk3theme.adw-gtk3-dark"
#  ];
#})
