
{ inputs
, config, lib, pkgs
, ...
}:
{
  # --- File Tree --------------------
  # File Tree plugin  # TODO: Compare:
  # - neo-tree   - nerdtree  - dirbuf.nvim  - iir.nvim
  # - nvim-tree  - nnn.nvim  - telescope-file-browser
  # TODO: Conditionally set NerdFonts icons in Neovim if we have a supported font installed.
  programs.nixvim.plugins.nvim-tree = {
    enable = false;
    diagnostics.enable = true;
    modified.enable = true;
  };
}

