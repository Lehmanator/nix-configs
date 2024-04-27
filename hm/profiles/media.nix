{ self, inputs, config, lib, pkgs,
  ...
}:
{
  home.packages = [

    # --- Audio Editors ------
    pkgs.imagemagickBig

    # --- Audio Players ------

    # --- Photo Editors ------
    # --- Photo Viewers ------
    pkgs.lsix                # Terminal image viewer
    pkgs.nufraw-thumbnailer  # Thumbnailer for RAW photos

    # --- Video Editors ------
    # --- Video Players ------
    pkgs.ffmpeg_6-full
    pkgs.ffmpegthumbnailer
    #pkgs.mpv

    # --- 3D Models ----------
    pkgs.vengi-tools        # Voxel engine & thumbnailer
  ];
}

