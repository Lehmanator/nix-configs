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
  ];

  # LiveCaptions app integration with GNOME.
  programs.gnome-shell.extensions = [{ package = pkgs.gnomeExtensions.live-captions-assistant; }];
}
