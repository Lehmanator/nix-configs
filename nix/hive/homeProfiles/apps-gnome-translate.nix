{ inputs
, config
, lib
, pkgs
, ...
}:
{
  home.packages = [
    pkgs.gnomeExtensions.live-captions-assistant # Ext: Better desktop integration b/w app & GNOME
    #pkgs.livecaptions #                          # Provides live captioning (broken 1/15/24: failed dep=python3.11-onnx-1.15.0)
    pkgs.dialect #                               # Translator
  ];

  services.flatpak.packages = [
    "flathub:app/com.mardojai.DiccionarioLengua//stable" # DiccionarioLengua
    "flathub:app/net.sapples.LiveCaptions//stable"
  ];

}
