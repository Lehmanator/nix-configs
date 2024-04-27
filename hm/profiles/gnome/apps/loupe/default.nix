{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [ pkgs.loupe ];
  xdg.mimeApps.defaultApplications = {
    "image/avif" = [ "org.gnome.Loupe.desktop" ];
    "image/bmp" = [ "org.gnome.Loupe.desktop" ];
    "image/gif" = [ "org.gnome.Loupe.desktop" ];
    "image/heic" = [ "org.gnome.Loupe.desktop" ];
    "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
    "image/jxl" = [ "org.gnome.Loupe.desktop" ];
    "image/png" = [ "org.gnome.Loupe.desktop" ];
    "image/svg+xml" = [ "org.gnome.Loupe.desktop" ];
    "image/svg+xml-compressed" = [ "org.gnome.Loupe.desktop" ];
    "image/tiff" = [ "org.gnome.Loupe.desktop" ];
    "image/vnd-ms.dds" = [ "org.gnome.Loupe.desktop" ];
    "image/vnd.radiance" = [ "org.gnome.Loupe.desktop" ];
    "image/webp" = [ "org.gnome.Loupe.desktop" ];
    "image/x-dds" = [ "org.gnome.Loupe.desktop" ];
    "image/x-exr" = [ "org.gnome.Loupe.desktop" ];
    "image/x-portable-anymap" = [ "org.gnome.Loupe.desktop" ];
    "image/x-portable-bitmap" = [ "org.gnome.Loupe.desktop" ];
    "image/x-portable-graymap" = [ "org.gnome.Loupe.desktop" ];
    "image/x-portable-pixmap" = [ "org.gnome.Loupe.desktop" ];
    "image/x-qoi" = [ "org.gnome.Loupe.desktop" ];
    "image/x-tga" = [ "org.gnome.Loupe.desktop" ];
  };

}
