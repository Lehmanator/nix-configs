{ inputs
, config
, lib
, pkgs
, ...
}:
{
  programs.nixvim.plugins.tagbar = {
    enable = lib.mkDefault false;
    extraConfig.show_tag_count = true;
  };
  home.packages = lib.mkIf config.programs.nixvim.plugins.tagbar.enable [pkgs.universal-ctags];
}
