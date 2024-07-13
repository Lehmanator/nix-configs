{ config, lib, pkgs , ... }: {
  home.packages = [
    pkgs.subdl         # Generate subtitles for video files
  ];
}
