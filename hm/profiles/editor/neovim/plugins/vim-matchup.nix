
{ self, inputs
, config, lib, pkgs
, ...
}:
{
  programs.nixvim.plugins.vim-matchup = {
    enable = lib.mkDefault false;
    enableSurround = lib.mkDefault true;
    enableTransmute = lib.mkDefault true;
    textObj.linewiseOperators = [ "d" "y" ]; # Modify set of operators which may operate line-wise
    # Include vim regex matches for symbols.
    # e.g. /* */ comments in C++ which are not supported by treesitter matching
    treesitterIntegration.enable = config.programs.nixvim.plugins.treesitter.enable;
    treesitterIntegration.includeMatchWords = true;
  };
}
