{ self, inputs
, config, lib, pkgs
, ...
}:
{
  # --- Telescope.nvim ---------------
  programs.nixvim.plugins.telescope = {
    enable = lib.mkDefault true;
    extensions = {
      frecency.enable = true;
      fzf-native.enable = true;
      #fzy-native.enable = true;
      media_files.enable = true;
      project-nvim.enable = config.programs.nixvim.plugins.project-nvim.enable;
    };
    #defaults = {};
    #extraOptions = {};
    #highlightTheme = nulll;
    #keymaps = { "<C-p>" = "git_files";
    #  "<leader>fg" = "live_grep"; };
  };
}
