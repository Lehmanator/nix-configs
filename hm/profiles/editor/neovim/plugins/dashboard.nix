{ inputs
, ...
}:
{
  programs.nixvim.plugins.dashboard = {
    enable = true;
    #header = ''
    #'';
    #center = {
    #  <name> = { action = ""; desc = ""; icon = ""; shortcut = ""; };
    #};
    #footer = ''
    #'';
    #hideStatusline = false;
    #hideTabline = false;
    #preview = { command = ""; file = ""; height = 40; width = 40; };
    #sessionDirectory = "";
  };
}
