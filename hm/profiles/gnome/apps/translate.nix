{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ];
  home.packages = [
    pkgs.gnomeExtensions.live-captions-assistant # Ext: Better desktop integration b/w app & GNOME
    pkgs.livecaptions #                          # Provides live captioning
    pkgs.dialect #                               # Translator
  ];

  services.flatpak.packages = [
    "flathub:app/com.mardojai.DiccionarioLengua//stable" # DiccionarioLengua
  ];

}
