{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.milahu.subdl         # Generate subtitles for video files
  ];

}
