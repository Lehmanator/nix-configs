{ self
, inputs
, outputs
, config
, lib
, pkgs
, options
, system
, host
, repo
, user
, network
, machine
, ...
}:
#lib.attrsets.recursiveUpdate
{

  environment.systemPackages = [
    pkgs.adw-gtk3
    pkgs.livecaptions
  ];

  gtk.iconCache.enable = true;

  # GTK3 plugin to show popup to search compatible application's menus
  programs.plotinus.enable = true;  #lib.mkDefault true;
  programs.sway.wrapperFeatures.gtk = true;
  #services.xserver.displayManager.lightdm.greeters.gtk.enable = lib.mkDefault true;

  services.dbus.packages = [
    pkgs.gcr # Allows gpg-agent & rbw to use pinentry-gnome3
    pkgs.gcr_4
  ];

  # Use GTK4 pinentry
  programs.ssh.askPassword = "${pkgs.gcr_4}/libexec/gcr4-ssh-askpass";
}

#(lib.optionalAttrs (options?services.flatpak.packages) {
#  services.flatpak.packages = [
#    "org.gtk.Gtk3theme.Adwaita-dark" "org.gtk.Gtk3theme.adw-gtk3" "org.gtk.Gtk3theme.adw-gtk3-dark"
#  ];
#})
