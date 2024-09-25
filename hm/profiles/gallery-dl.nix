{ config, lib, pkgs, ... }:
{
  programs.gallery-dl = {
    enable = true;
    settings = {
      extractor.base-directory = "~/Pictures/Social/Download";
      extractor.instagram.include = [ "posts" "tagged" "avatar" ]; #"reels" "stories" "highlights"
      extractor.instagram.previews = true;
      extractor.instagram.videos = true;
      extractor.instagram.api = "rest";
      extractor.instagram.cookies = [ "firefox" ]; # "default" "" "Social" ];
      extractor.instagram.cookies-update = true;
    };
  };
}
