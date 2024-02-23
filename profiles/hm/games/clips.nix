{ inputs, config, lib, pkgs, ... }:
{
  imports = [ ];

  home.packages = [
    #pkgs.fd
    pkgs.ffmpeg_6-full
  ];

  home.shellAliases = {
    # TODO: Slo-mo alias
    # TODO: Compression alias
    # TODO: Last clip retriever
    # TODO: Make GIF
    ff = "ffmpeg -i";
    ff5 = "ffmpeg -ss 5 -i";
    ff10 = "ffmpeg -ss 10 -i";
    ff15 = "ffmpeg -ss 15 -i";
  };

}
