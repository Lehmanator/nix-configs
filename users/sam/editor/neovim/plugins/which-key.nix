{ inputs, ... }:
{
  programs.nixvim.plugins.which-key = {
    enable = true;
    #window.border = [""];
  };
}
