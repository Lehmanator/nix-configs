{ inputs
, config
, lib
, pkgs
, ...
}:
# --- Neorg ------------------------
# Organization file format: .norg
# https://github.com/nvim-neorg/neorg
{
  programs.nixvim.plugins.neorg = {
    enable = lib.mkDefault true;
    lazyLoading = true;

    extraOptions = {
    };

    modules = {
      # --- Default Modules ---
      #"core.defaults".config.disable = [];
      #"core.clipboard.code-blocks" = {}; "core.looking-glass" = {}; "core.itero" = {};
      #"core.keybinds".config.default_keybinds = true; # TODO: Set `localleader` for `.norg` files
      #"core.norg.esupports.indent".config = {};
      #"core.norg.esupports.hop".config = { external_filetypes = []; };
      #"core.norg.news"={}; "core.norg.qol.toc"={}; "core.norg.qol.todo_items"={}; "core.promo"={}; "core.tangle"={}; "core.upgrade" = {};
      "core.norg.esupports.metagen".config = { type = "auto"; update_date = true; };
      "core.norg.journal".config = {
        journal_folder = "${config.home.homeDirectory}/Notes/Journal";
        strategy = "flat";
        #workspace = "journal";
      };

      # --- Other Modules ---
      "core.norg.dirman".config.workspaces = {
        # Manage directories of .norg files
        work = "${config.home.homeDirectory}/Notes/Work";
        home = "${config.home.homeDirectory}/Notes/Home";
        #journal="${config.home.homeDirectory}/Notes/Journal";
      };
      "core.export.markdown".config.extensions = "all"; # Export .norg docs to other supported filetypes
      "core.norg.completion".config.engine = "nvim-cmp"; # TODO: Set `sources={ {name="neorg"},},` as source in `nvim-cmp`
      "core.presenter".config.zen_mode = "zen-mode"; # (zen-mode | truezen)
      "core.export" = { };
      "core.norg.concealer" = { };

      # --- Developer Modules ---
      # core: autocommands, clipboard, defaults, fs, highlights, mode, scanner, storage, syntax
      # core.integrations: nvim-cmp, nvim-compe, treesitter, truezen, zen_mode
      # core.neorgcmd: ., commands.module.list, commands.module.load, commands.return
      # core.norg.dirman.utils core.queries.native
      "core.clipboard" = { };
      "core.scanner" = { };
      "core.syntax" = { };

      # --- Community Modules ---
      # https://github.com/nvim-neorg/neorg-telescope

    };
  };
}
