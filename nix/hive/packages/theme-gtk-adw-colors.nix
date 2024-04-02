{
  lib,
  stdenv,
  fetchFromGitHub,
}:
# TODO: nixosModules.adw-colors & homeManagerModules.adw-colors
# - options.light-theme = "solarized";
# - config.xdg.configFile."gtk-3.0/gtk-light.css".text = "@import url(\"${pkgs.adw-colors}/${cfg.light-theme}/gtk.css\");"
# - config.xdg.configFile."gtk-3.0/gtk-dark.css".text = "@import url(\"${pkgs.adw-colors}/${cfg.dark-theme}/gtk.css\");"
# - config.gtk.gtk-3.0.extraCss = '@import url("${pkgs.adw-colors}/${cfg.light-theme}/gtk.css")';
stdenv.mkDerivation {
  pname = "adw-colors";
  version = "5.2.0";
  #version = "unstable-2024-02-01";

  src = fetchFromGitHub {
    owner = "lassekongo83";
    repo = "adw-colors";
    rev = "336a5697c36995219217546fd0427a0eea705959";
    hash = "sha256-nBnFBSs6xJtpEZSUC9PQB/2iR8X3bjZr0Suq3bSZovU=";
    #hash = "sha256-r/y8MqVlnlnvWsVKZDb0Xl6W6tMqmWVXpg3bKFiQYFI=";
  };

  meta = {
    description = "Style libadwaita & adw-gtk3 with named colors";
    homepage = "https://github.com/lassekongo83/adw-colors";
    #maintainers = with lib.maintainers; [lehmanator];
    license = lib.licenses.unfree; # FIXME: nix-init did not found a license
    platforms = lib.platforms.all;
  };
}
