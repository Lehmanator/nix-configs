{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./clipboard.nix
    ./keymaps.nix
    ./styles
  ];

  programs.nixvim = {
    luaLoader.enable = true;
  };
}
