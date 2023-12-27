{ config, lib, pkgs, ... }: {
  imports = [
  ];

  programs.nixvim.plugins.nvim-ufo = {
    enable = true;
    enableGetFoldVirtText = true;

    #closeFoldKinds = null;  # LSP provider: comment | imports | region (run UfoInspect for details)
    #extraOptions = { };
    #package = pkgs.vimPlugins.nvim-ufo;
    #foldVirtTextHandler = ''
    #'';
    #openFoldHlTimeout = 400;
    #preview = {
    #  mappings = {};
    #  # TODO: Set styles globally.
    #  winConfig = {
    #    border = "rounded";
    #    maxheight = 20;
    #    winblend = 12;
    #    winhighlight = "Normal:Normal";
    #  };
    #};
    #providerSelector = null;  # Lua function as a selector for fold providers
  };
}
