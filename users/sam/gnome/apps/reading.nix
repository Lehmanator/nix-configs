{ inputs
, config
, lib
, pkgs
, ...
}:
{
  home.packages = [
    pkgs.foliate #                  # eBook reader GTK4 app
    pkgs.gnome-epub-thumbnailer #   # Thumbnail generator for .EPUB eBooks (Nautilus previews)
    pkgs.newsflash #                # RSS feed reader
    pkgs.wike #                     # Wikipedia article viewer
    #pkgs.nur.repos.colinsane.cozy  # Audiobook reader GTK3 app  # Error: collision of symbolic icon w/ BlackBox
  ];

  # TODO: Set MIME types for eBooks, RSS feeds, audiobooks

}
