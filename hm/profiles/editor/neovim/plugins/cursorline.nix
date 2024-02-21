{ ... }:
{
  programs.nixvim.plugins.cursorline = {
    enable = true;

    cursorline = {
      enable = true;
      number = true; # bool | raw lua code
      timeout = 200;
    };

    cursorword = {
      enable = true;
      #hl = "{underline = true;}";
      minLength = 3;
    };

    #extraOptions = {
    #};
  };
}
