{ config, lib, pkgs, ... }:
{
  programs.fd = {
    enable = true;
    package = pkgs.fd;
    hidden = false;
    ignores = [".git/"];
    # extraOptions = [
    #   "--no-ignore"
    #   "--absolute-path"
    # ];
  };
}
