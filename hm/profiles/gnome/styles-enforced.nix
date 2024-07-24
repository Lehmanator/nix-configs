{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [ ./styles.nix ];

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
    platformTheme.name = "adwaita";
    style.package = pkgs.adwaita-qt;
    style.name = "adwaita-dark";
  };

  # --- Desktop Shell ---
  # Dunst: Notification Daemon
  services.dunst.iconTheme = { name = "Adwaita"; package = pkgs.adwaita-icon-theme; };

}
