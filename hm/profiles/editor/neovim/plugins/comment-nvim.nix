{ inputs
, lib, config, pkgs
, ...
}:
{
  programs.nixvim.plugins.comment-nvim = {
    enable = lib.mkDefault true;
    mappings = {
      basic = true;
      extra = true;
    };
    padding = false;
    #sticky = false;
  };
}
