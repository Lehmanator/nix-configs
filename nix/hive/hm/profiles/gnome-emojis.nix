{ cell
, pkgs, lib
, ... 
}:
let
  inherit (lib) mkIf;
  prefer-flatpak = false;
in
{
  imports = [ cell.homeProfiles.app-gnome-smile ];

  # --- GNOME Apps ---
  home.packages = [];
  
  #  Emoji kitchen
  services.flatpak.packages = [ "io.github.halfmexican.Mingle" ];

  # https://extensions.gnome.org/extension/6242/emoji-copy
  # programs.gnome-shell.extensions = [{package=pkgs.gnomeExtensions.emoji-copy;}];  
}
