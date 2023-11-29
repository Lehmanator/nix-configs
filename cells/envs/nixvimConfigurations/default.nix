{ inputs
, config
, osConfig
, pkgs
, lib
, ...
}:
# Standalone Nixvim config
# --- Usage ---
# - nixvim.legacyPackages.${pkgs.system}.makeNixvim           { ... nixvim config ... }
# - nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule { ... nixvim config ... }
#
# --- Devshell ---
# let
#   nvim = nixvim.legacyPackages.${pkgs.system}.makeNixvim {
#     plugins.lsp.enable = true;
#   };
# in pkgs.mkShell {
#   buildInputs = [nvim];
# };
{
  pkgs = inputs.nixpkgs.legacyPackages.${pkgs.system};
  extraSpecialArgs = { inherit inputs config osConfig pkgs; };
  module = { };

  # --- Options ----------------------------------
  enableMan = true;
  luaLoder.enable = true;

  clipboard = {
    register = "unnamedplus";
    providers = {
      # :h clipboard
      wl-copy.enable = lib.mkDefault true;
      xclip.enable = lib.mkDefault false;
      xsel.enable = lib.mkDefault false;
    };
  };

  editorconfig = {
    enable = true;
    properties = {
      #foo = ''
      #  function(bufnr, val, opts)
      #  end
      #'';
    };
  };

  # --- Colorschemes -----------------------------
  colorscheme = "catppuccin";
  colorschemes.catppuccin = {
    enable = true;
    flavor = "latte";
    disableBold = false;
    disableItalic = false;
    disableUnderline = false;
    showBufferEnd = false;
    terminalColors = true;
    transparentBackground = true;
    background = { dark = "latte"; light = "frappe"; };
    colorOverrides = {
      all = { };
      frappe = { };
      latte = { };
      macchiato = { };
      mocha = { };
    };
    customHighlights = { };
    dimInactive = {
      enabled = true;
      percentage = 0.10;
      shade = null; #"dark";
    };
    integrations = {
      dap.enable_ui = true;
      dap.enabled = true;
      indent_blankline.enabled = true;
      indent_blankline.colored_indent_levels = true;
      native_lsp.enabled = true;
      which_key = true;
    };
    styles = { };
  };

  # --- Extra Config -----------------------------
  extraConfigLua = ''
  '';
  extraConfigLuaPost = ''
  '';
  extraConfigLuaPre = ''
  '';
  extraConfigVim = ''
  '';
  extraFiles = { };
  extraLuaPackages = {}: [ ];
  extraPackages = [ pkgs.fzf ];
  extraPlugins = [ ];
  path = "nixvim.lua"; #vim";
  type = "lua";

  # --- Vim Config -------------------------------
  globals = { };
  options = { };
  autoCmd = [
    {
      event = [ "BufEnter" "BufWinEnter" ];
      pattern = [ "*.c" "*.h" ];
      command = "echo 'Entering C or C++ file'";
      callback = { __raw = "function() print('This buffer enters') end"; };
      desc = "Description";
      group = "autocommandGroupName";
      nested = false;
      once = false;
    }
  ];
  autoGroups = {
    myaugroup = {
      clear = true;
    };
  };
  filetype = {
    extension = null; # attrset of str|luaCode|list<str|submodule>
    filename = null;
    pattern = null;
  };
  highlight = { };
  maps = {
    command = { };
    insert = { };
    insertCommand = { };
    lang = { };
    normal = { };
    normalVisualOp = { };
    operator = { };
    select = { };
    terminal = { };
    visual = { };
    visualOnly = { };
  };
  keymaps = [ ];
  userCommands = { };

  # --- Plugins ----------------------------------
  plugins = { };
}
