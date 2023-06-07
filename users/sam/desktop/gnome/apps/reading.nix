{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  home.packages = [
    pkgs.foliate                   # eBook reader GTK4 app
    pkgs.gnome-epub-thumbnailer    # Thumbnail generator for .EPUB eBooks (Nautilus previews)
    pkgs.newsflash                 # RSS feed reader
    pkgs.wike                      # Wikipedia article viewer
  ];
}
