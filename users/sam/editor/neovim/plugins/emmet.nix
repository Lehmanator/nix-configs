
{ self, inputs
, config, lib, pkgs
, ...
}:
{
  programs.nixvim.plugins = {
    emmet = {
      enable = false;
      leader = null;
      mode = null; # i | n | v | a
      settings = null;
    };
  };
}
