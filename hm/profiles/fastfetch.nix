{ config, lib, pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;

    # https://github.com/fastfetch-cli/fastfetch/wiki/Json-Schema
    settings = {
    };
  };
}
