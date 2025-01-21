{ config, lib, pkgs, ... }:
# https://wiki.nixos.org/wiki/Thumbnails
# https://specifications.freedesktop.org/thumbnail-spec/latest/index.html
let
  # Thumbnailer for Krita's `.kra` file format
  #   `.kra` are zip files, w/ preview stored at `/preview.png`
  #   so we use `unzip` to extract the preview: 
  extra-thumbnailers = {
    krita = pkgs.writeTextFile {
      name = "krita-thumbnailer";
      destination = "/share/thumbnailers/kra.thumbnailer"; # Important: Path to install this
      text = ''
        [Thumbnailer Entry]
        Exec=sh -c "${pkgs.unzip}/bin/unzip -p %i preview.png > %o"
        MimeType=application/x-krita;
      '';
    };
    # This is implemented by: pkgs.webp-pixbuf-loader
    webp = pkgs.writeTextFile {
      name = "webp-thumbnailer";
      destination = "/share/thumbnailers/webp.thumbnailer"; # Important: Path to install this
      text = ''
        [Thumbnailer Entry]
        TryExec="${pkgs.webp-pixbuf-loader}/libexec/gdk-pixbuf-thumbnailer-webp";
        Exec="${pkgs.webp-pixbuf-loader}/libexec/gdk-pixbuf-thumbnailer-webp";
        Exec=sh -c "${pkgs.unzip}/bin/unzip -p %i preview.png > %o"
        MimeType=application/x-krita;
      '';
    };
  };
  
in
{
  environment.systemPackages = [
    pkgs.epeg                        # Insanely fast JPEG/ JPG thumbnail scaling
    pkgs.ffmpegthumbnailer           # Lightweight video thumbnailer
    pkgs.webp-pixbuf-loader
    pkgs.texlivePackages.thumbpdf    # Thumbnails for pdfTeX and dvips/ps2pdf
    pkgs.xfce.tumbler                # D-Bus thumbnailer service
    pkgs.gnome-epub-thumbnailer      # Thumbnailer for EPub and MOBI books
    pkgs.lomiri.lomiri-thumbnailer   # D-Bus service for out of process thumbnailing
    pkgs.epub-thumbnailer            # Script to extract the cover of an epub book and create a thumbnail for it
    pkgs.bign-handheld-thumbnailer   # Thumbnailer for Nintendo handheld systems (Nintendo DS and 3DS) roms and files
    pkgs.vengi-tools                 # vengi voxel engine tools, incl. thumbnailer, converter, & VoxEdit voxel editor
    pkgs.thud                        # Generate directory thumbnails for GTK-based file browsers from images inside them
    pkgs.gnome-font-viewer           # Program that can preview fonts and create thumbnails for fonts
    pkgs.nufraw-thumbnailer          # Utility to read and manipulate raw images from digital cameras
    pkgs.fbida                       # Image viewing and manipulation programs including fbi, fbgs, ida, exiftran and thumbnail.cgi
    extra-thumbnailers.krita
  ];

  home-manager.sharedModules = [
    ({
      home.file = {
        ".local/share/thumbnailers/kra.thumbnailer".text = ''
          [Thumbnailer Entry]
          TryExec=unzip
          Exec=sh -c "${pkgs.unzip}/bin/unzip -p %i preview.png > %o"
          MimeType=application/x-krita;
        '';
      };
    })
  ];


  # From: https://ruvi-d.medium.com/demystifing-thumbnails-32384bcdbe36
  # TODO: Set dconf settings for: `/org/gnome/desktop/thumbnail-cache` keys: `maximum-age` & `maximum-size`
  # - Increase `maximum-size` beyond the puny `512` (Megabytes)
}
