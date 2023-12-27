{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [];
  programs.nixvim.plugins.notify = {
    enable = true;
    backgroundColour = "#000000";
    #stages = "fade_in_slide_out";  # fade|slide|static
  };
}
