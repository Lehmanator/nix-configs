{ self, inputs
,config, lib, pkgs
, ...
}:
let
  # TODO: Make similar file for border styles
  # TODO: Pass toggle bools as arguments
  iconsEnabled = true;
in
{
  programs.nixvim.plugins = {
    alpha.iconsEnabled = iconsEnabled;
    nvim-tree.renderer.indentMarkers.enable = iconsEnabled;
    nvim-tree.renderer.icons.show = {
      file = iconsEnabled;
      folder = iconsEnabled;
      folderArrow = iconsEnabled;
      git = iconsEnabled;
      modified = iconsEnabled;
      symlinkArrow = iconsEnabled;
    };
    trouble.icons = iconsEnabled;
    trouble.indentLines = iconsEnabled;
    telescope.extensions.frecency.deviconsDisabled = !iconsEnabled;
  };
}
