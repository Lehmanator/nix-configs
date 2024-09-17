{ lib, pkgs, ... }:
let
  prefer-flatpak = true;
in
{
  home.packages = lib.mkIf (! prefer-flatpak) [
    pkgs.livecaptions # Provides live captioning (broken 1/15/24: failed dep=python3.11-onnx-1.15.0)
    pkgs.dialect #    # Translation app
  ];

  services.flatpak.packages = [ "com.mardojai.DiccionarioLengua" ] ++ lib.optionals prefer-flatpak [
    "net.sapples.LiveCaptions"
    "app.drey.Dialect"
    "cool.ldr.lfy"
    # "org.kde.CrowTranslate"  # KDE app
    # "net.mkiol.SpeechNote"   # KDE app. Might be useful for other desktops b/c it also does TTS & STT
  ];

  # LiveCaptions app integration with GNOME.
  programs.gnome-shell.extensions = [{ package = pkgs.gnomeExtensions.live-captions-assistant; }];

  # --- Dictionary ---
  # "one.jiri.easydict-gtk"  # GTK3

  # --- Developer Translation ---
  # TODO: Mechanism for specifying if developer?: `builtins.elem config.roles "dev"`
  # ] ++ lib.optionals (config.services.xserver.desktopManager.default == "gnome") [
  #   "net.poedit.Poedit"     # GTK2/3
  #   "com.pot_app.pot"
  #   "org.gnome.Gtranslator" # GTK
  # ] ++ lib.optionals (config.services.xserver.desktopManager.default == "plasma") [
  #   "org.kde.lokalize"      # KDE
  # ];
}
