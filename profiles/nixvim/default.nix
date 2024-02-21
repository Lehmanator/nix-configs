{
  pkgs,
  uiShape ? "rounded",
  ...
}:
# --- NixVim ---
# Configures Neovim via Nix modules
# https://github.com/pta2002/nixvim
# https://pta2002.github.io/nixvim
# TODO: Split into:
# - `nixvimConfigurations`
# - `nixvimProfiles`
# - `nixvimSuites`
# TODO: Build final `nixvimConfigurations.<name>` using:
# - `inputs.nixvim.legacyPackages.${system}.makeNivim`
# - `inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule`
# TODO: Configure new plugins:
# - auto-session
# - indent-blankline
# - mini
# - toggleterm
# - ts-autotag
# - typst-vim
# - undotree
# - which-key
# TODO: plugins.nvim-lsp - Configure new language servers:
# - ccls
# - java
# - kotlin
# - nixd
# TODO: Global style setting:
# - borderStyle
# - colorscheme
# TODO: Fix issues
# - package rename: nodePackages.vscode-langservers-extracted -> vscode-langservers-extracted
# - telescope-frecency: Stop asking to remove database entries
# - nvim-notify: Missing background color for popup UI
# - Diagnostic inline multiline as concealed / virtual text or popup menu instead of moving contents
# TODO: lib.exportNeovimKeybinds <neovimConfig>
# TODO: lib.exportNixvimKeybinds <nixvimConfig>
# TODO: lib.exportVimKeybinds       <vimConfig>
{
  imports = [
    #inputs.nixvim.homeManagerModules.nixvim
    #../editorconfig.nix
    ./clipboard.nix
    ./colorschemes
    ./keymaps.nix
    ./langs
    ./plugins
    ./styles
  ];

  config = {
    options = {
      # --- Lines ---
      number = true;
      relativenumber = true;
      # --- Indentation ---
      shiftwidth = 2;
      foldlevel = 10;
      # --- Integration ---
      title = true;
      # --- Mouse ---
      mousescroll = "ver:1,hor:2";
      mouse = "a"; # "nv";
    };

    # TODO: Move options to colorschemes?
    highlight = {
      #IndentBlanklineIndent2.ctermfg = "bg";
      #IndentBlanklineIndent1 = { fg = "NONE"; ctermfg = "NONE"; };
      lualine_c_active.bg = "NONE";
      lualine_c_inactive.bg = "NONE";
      lualine_x_active.bg = "NONE";
      lualine_x_inactive.bg = "NONE";
      lualine_x_normal.bg = "NONE"; # lualine_x_normal.bg = "NONE";
      lualine_c_normal.bg = "NONE"; # lualine_c_normal.bg = "NONE";
      lualine_x_insert.bg = "NONE"; # lualine_x_insert.bg = "NONE";
      lualine_c_insert.bg = "NONE"; # lualine_c_insert.bg = "NONE";
      TabLineFill.bg = "NONE";
      TabLineFill.fg = "NONE";
      StatusLine.bg = "NONE";
      StatusLineNC.bg = "NONE";
      #StatusLine.fg = "NONE"; "black";
      StatusLineNC.fg = "NONE";
    };
  };

  # --- Home-Manager Options ---------------------------------------------------
  #enable = true;
  #enableMan = false; # Enable manpages for nixvim options
  #defaultEditor = true; # home-manager option, not nixvim

  # --- Aliases ---
  #viAlias = false;
  #vimAlias = true;

  # --- Neovim ---------------------------------------------
  #programs.neovim.withNodeJs = true;
  #programs.neovim.withPython3 = true;
  #programs.neovim.plugins = with pkgs.vimPlugins; [
  #  { plugin = nvim-treesitter.withAllGrammars; }
  #];
}
