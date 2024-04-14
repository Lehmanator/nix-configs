{
  config,
  lib,
  pkgs,
  ...
}: {
  plugins.tagbar = {
    enable = lib.mkDefault false;
    settings = {show_tag_count = true;};
  };

  # Note: mkIf on a mkDefault option causes infinite recursion
  #home.packages = lib.mkIf config.programs.nixvim.plugins.tagbar.enable [pkgs.universal-ctags];
  #home.packages = [pkgs.universal-ctags];
}
