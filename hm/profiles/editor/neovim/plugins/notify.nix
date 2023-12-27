{ inputs, config, lib, pkgs, ... }:
{
  programs.nixvim.plugins.notify = {
    enable = true;
    backgroundColour = lib.mkDefault "#000000";
    minimumWidth = 20; # d: 50
    maxWidth = 65;  # d:
    maxHeight = 15; # d:null
    level = "warn"; # d:info
    timeout=3000; # d:5000
    topDown=true;
    #stages = "fade_in_slide_out";  # fade|slide|static
  };
}
