{ inputs, config, lib, pkgs, ... }: {
  home.packages = lib.mkIf config.gtk.enable [
    pkgs.adwaita-icon-theme
    pkgs.adw-gtk3
    pkgs.gradience
    pkgs.nur.repos.federicoschonborn.morewaita
  ] ++ lib.optionals config.qt.enable [ pkgs.adwaita-qt pkgs.adwaita-qt6 ]
  ++ lib.optional config.programs.vscode.enable
    pkgs.vscode-extensions.piousdeer.adwaita-theme ++ lib.optional
    (config.programs.firefox.enable || config.programs.librewolf.enable)
    pkgs.nur.repos.federicoschonborn.firefox-gnome-theme;

  # --- Qt Applications ---
  qt = lib.mkIf config.gtk.enable {
    platformTheme = "gnome";
    style.package = pkgs.adwaita-qt;
    style.name = "adwaita-dark";
  };

  # --- Pinentry ---
  programs.rbw.settings.pinentry =
    lib.mkIf config.gtk.enable "gnome3"; # TODO: Use grc_4 like with gpg-agent
  services = lib.mkIf config.gtk.enable {
    gpg-agent = {
      # Use GTK4 pinentry (requires services.dbus.packages = [ pkgs.gcr_4 ];)
      #pinentryFlavor = null;   # Overriding default to use GTK4. Default=gtk2, gnome3 (when gnome desktop enabled)
      #extraConfig = ''
      #  pinentry-program ${pkgs.gcr_4}/libexec/gcr4-ssh-askpass
      #'';
    };

    # --- Desktop Shell ---
    # Dunst: Notification Daemon
    dunst.iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };
}
