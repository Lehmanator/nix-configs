{ self, inputs
, config, lib, pkgs
, ...
}:
{
  # --- Treesitter -------------------
  programs.nixvim.plugins = {
    cmp-treesitter.enable = config.programs.nixvim.plugins.nvim-cmp.enable;
    treesitter = {
      enable = lib.mkDefault true;
      ensureInstalled = "all";
      folding = true;
      incrementalSelection = {
        enable = true;
        keymaps = { initSelection = "gnn"; nodeDecremental = "grm"; nodeIncremental = "grn"; scopeIncremental = "grc"; };
      };
      indent = true;
      nixGrammars = true;
      nixvimInjections = true; # Enable Nixvim-specific injections (like Lua highlighting in extraConfigLua)
    };
    treesitter-context.enable = lib.mkDefault true;
    treesitter-playground.enable = lib.mkDefault true;
    treesitter-rainbow.enable = lib.mkDefault false;
    treesitter-refactor = {
      enable = lib.mkDefault true;
      highlightCurrentScope.enable = false;
      highlightDefinitions.enable = true;
      navigation.enable = true;
      smartRename.enable = true;
    };
  };
}
