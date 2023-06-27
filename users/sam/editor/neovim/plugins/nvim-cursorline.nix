{ ... }:
{
  programs.nixvim.plugins.cursorline = {
    enable = true;
    cursorline.enable = true;
    cursorline.number = true;
    cursorword.enable = true;
    #cursorword.hl = "{underline = true;}";
  };
}
