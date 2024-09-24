{ config, lib, pkgs, ... }:
#
# tealdeer: Command usage examples
#  Config: https://dbrgn.github.io/tealdeer/config.html
#
{
  programs.tealdeer = {
    enable = true;
    settings = {
      display.compact = true;
      display.use_pager = false;
      updates.auto_update = true;
      #style.example_variable.foreground = "cyan";
    };
  };
}
