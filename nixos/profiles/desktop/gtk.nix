{ config, lib, pkgs, user, ... }: {
  # Default settings for GTK-based desktops

  gtk.iconCache.enable = true;

  #environment.sessionVariables.GTK3_MODULES = ["${pkgs.plotinus}/lib/libplotinus.so"];
  environment.systemPackages = [
    #pkgs.livecaptions # Build failing as of 1/15/24: failing dep=python3.11-onnx-1.15.0
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

  # GTK3 plugin to show popup to search compatible application's menus
  programs.plotinus.enable = lib.mkDefault true;

  # Use GTK4 pinentry
  services.dbus.packages = with pkgs; [gcr gcr_4]; # Let gpg-agent/rbw use pinentry-gnome3
  #programs.ssh.askPassword = "${pkgs.gcr_4}/libexec/gcr4-ssh-askpass";

  xdg.portal.extraPortals = lib.mkIf (!config.services.xserver.desktopManager.gnome.enable) [pkgs.xdg-desktop-portal-gtk];

  programs.sway.wrapperFeatures.gtk = true;
  #services.xserver.displayManager.lightdm.greeters.gtk.enable = lib.mkDefault true;

}

#(lib.optionalAttrs (options?services.flatpak.packages) {
#  services.flatpak.packages = [
#    "org.gtk.Gtk3theme.Adwaita-dark" "org.gtk.Gtk3theme.adw-gtk3" "org.gtk.Gtk3theme.adw-gtk3-dark"
#  ];
#})
