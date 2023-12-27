{ ... }:
{
  programs.nixvim.plugins.cursorline = {
    enable = true;
    cursorline.enable = true;
    cursorline.number = true;
    cursorline.timeout = 200;
    cursorword.enable = true;
    #cursorword.hl = "{underline = true;}";
    cursorword.minLength = 3;
  };
}
