{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.mic92.bing-image-creator
    pkgs.nur.repos.foolnotion.upscayl
  ];

}
