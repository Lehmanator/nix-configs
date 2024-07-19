{ cell, lib, pkgs, ... }:

# TODO: Split eBook reader config to separate file.
# TODO: Set MIME types for eBooks, audiobooks
# TODO: Special setup for thumbnailers in Nautilus

{
  # TODO: Remove import?
  imports = [ cell.homeProfiles.apps-gnome-rss ];

  home.packages = [
    pkgs.foliate #                  # eBook reader GTK4 app
    pkgs.gnome-epub-thumbnailer #   # Thumbnail generator for .EPUB eBooks (Nautilus previews)
    pkgs.wike #                     # Wikipedia article viewer
    #pkgs.nur.repos.colinsane.cozy  # Audiobook reader GTK3 app  # Error: collision of symbolic icon w/ BlackBox
  ];


  # dconf.settings = {
  #   "org/gnome/" = {};
  # };

}
