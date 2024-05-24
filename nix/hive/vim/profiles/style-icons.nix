{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  # TODO: Make similar file for border styles
  # TODO: Pass toggle bools as arguments
  iconsEnabled = true;
in {
  plugins = {
    alpha.iconsEnabled = iconsEnabled;
    nvim-tree.renderer = {
      indentMarkers.enable = iconsEnabled;
      icons.show = {
        file = iconsEnabled;
        folder = iconsEnabled;
        folderArrow = iconsEnabled;
        git = iconsEnabled;
        modified = iconsEnabled;
        symlinkArrow = iconsEnabled;
      };
    };
    trouble = {
      icons = iconsEnabled;
      indentLines = iconsEnabled;
    };
    #telescope.extensions.frecency.deviconsDisabled = !iconsEnabled;
  };
}
