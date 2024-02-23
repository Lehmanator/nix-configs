
{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.adwaita-qt
    pkgs.qt6Packages.qt6ct
    pkgs.libsForQt5.qt5ct
    pkgs.gcr_4
  ];

  # --- Qt Applications ---
  qt = {
    enable = true;
    platformTheme = "gnome";
    style.package = pkgs.adwaita-qt;
    style.name = "adwaita-dark";
  };

  # --- Pinentry ---
  programs.rbw.settings.pinentry = "gnome3";  # TODO: Use grc_4 like with gpg-agent
  services.gpg-agent = {     # Use GTK4 pinentry (requires services.dbus.packages = [ pkgs.gcr_4 ];)
    #pinentryFlavor = null;   # Overriding default to use GTK4. Default=gtk2, gnome3 (when gnome desktop enabled)
    #extraConfig = ''
    #  pinentry-program ${pkgs.gcr_4}/libexec/gcr4-ssh-askpass
    #'';
  };

  # --- Desktop Shell ---
  # Dunst: Notification Daemon
  services.dunst.iconTheme.name = "Adwaita";
  services.dunst.iconTheme.package = pkgs.adwaita-icon-theme;

}
