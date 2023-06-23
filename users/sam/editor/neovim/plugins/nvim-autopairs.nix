
{ self, inputs
, config, lib, pkgs
, ...
}:
{

  # --- Pairs ------------------------
  # Insert, remove, highlight syntax pairs
  programs.nixvim.plugins.nvim-autopairs = {
    enable = false;
    checkTs = true;
    disableInMacro = false;
    mapCW = true;             # Delete pair w/ CTRL-W
  };
}
