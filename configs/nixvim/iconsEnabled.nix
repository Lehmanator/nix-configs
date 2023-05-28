{ self, inputs
,config, lib, pkgs
, ...
}:
{
  programs.nixvim.plugins = {
    alpha.iconsEnabled = true;
    nvim-tree.renderer.icons.show = {
      file = true;
      folder = true;
      folderArrow = true;
      git = true;
      modified = true;
      symlinkArrow = true;
    };
    nvim-tree.renderer.indentMarkers.enable = true;
    trouble.icons = true;
    trouble.indentLines = true;
    telescope.extensions.frecency.deviconsDisabled = false;
  };
}
