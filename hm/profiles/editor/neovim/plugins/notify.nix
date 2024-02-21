{
  config,
  lib,
  ...
}: {
  programs.nixvim.plugins.notify = {
    enable = true;
    backgroundColour = lib.mkDefault "#000000";
    minimumWidth = 20; # d: 50
    maxWidth = 65; # d:
    maxHeight = 15; # d:null
    level = "warn"; # d:info
    timeout = 2500; # d:5000
    topDown = false;
    #stages = "fade_in_slide_out";  # fade|slide|static
  };
}
