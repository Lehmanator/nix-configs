
{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./styles.nix
  ];

  home.packages = [
    pkgs.nur.repos.federicoschonborn.firefox-gnome-theme
    pkgs.nur.repos.federicoschonborn.morewaita
    pkgs.vscode-extensions.piousdeer.adwaita-theme
    pkgs.adw-gtk3
    pkgs.adwaita-qt
    pkgs.adwaita-qt6
    pkgs.gradience
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
