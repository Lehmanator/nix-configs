{ self, inputs
, config, lib, pkgs
, ...
}:
{
  # --- Treesitter -------------------
  programs.nixvim.plugins = {
    cmp-treesitter.enable = true;
    treesitter = {
      enable = true;
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
    treesitter-context.enable = true;
    treesitter-playground.enable = true;
    treesitter-rainbow.enable = false;
    treesitter-refactor = {
      enable = true;
      highlightCurrentScope.enable = false;
      highlightDefinitions.enable = true;
      navigation.enable = true;
      smartRename.enable = true;
    };
  };
}
