{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.mic92.noise-suppression-for-voice   # Plugin based on Xiph's RNNoise
  ];

}
