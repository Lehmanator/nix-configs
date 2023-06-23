{ inputs
, config, lib
, ...
}:
let
  isLspCmp = with config.programs.nixvim.plugins; lsp.enable && nvim-cmp.enable;
in
{

  programs.nixvim.plugins = {
    cmp-nvim-lsp.enable = lib.mkDefault isLspCmp;
    cmp-nvim-lsp-document-symbol.enable = lib.mkDefault isLspCmp;
    cmp-nvim-lsp-signature-help.enable = lib.mkDefault isLspCmp;
    cmp-vim-lsp.enable = lib.mkDefault isLspCmp;
    # --- Language Server Protocol -----
    lsp = {
      enable = true;
      keymaps.diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      keymaps.lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
        ca = "code_action";
        ff = "format";
      };
      # TODO: Re-enable commented language servers after `inputs.nixos-unstable.pkgs.vscode-langservers-extracted` build succeeds again.
      servers = {
        bashls.enable = true;
        clangd.enable = true;
        #cssls.enable = true;
        dartls.enable = true;
        #eslint.enable = true;
        gopls.enable = true;
        #html.enable = true;
        #jsonls.enable = true;
        lua-ls.enable = true;
        tailwindcss.enable = true;
        terraformls.enable = true;
        tsserver.enable = true;
        vuels.enable = true;
        zls.enable = true;
      };
    };

    # lsp-lines - LSP multi-line diagnostics in-editor
    lsp-lines = {
      enable = lib.mkDefault config.programs.nixvim.plugins.lsp.enable;
      currentLine = false;
    };
    lsp-format = {
      enable = lib.mkDefault config.programs.nixvim.plugins.lsp.enable;
      lspServersToEnable = "all";
    };

    # lspkind.nvim - Entry types for LSP Completions w/ icons
    lspkind = {
      enable = lib.mkDefault config.programs.nixvim.plugins.lsp.enable;
      cmp.enable = lib.mkDefault isLspCmp;
      mode = "symbol_text"; #text,text_symbol,symbol_text*,symbol
      preset = "codicons"; #codicons,default
    };

    # lspsaga.nvim - LSP enhancements
    # TODO: Compatible with Noice?
    lspsaga = {
      enable = lib.mkDefault config.programs.nixvim.plugins.lsp.enable;
      borderStyle = "rounded";
    };

    # inc-rename - Incremental previewing LSP renaming
    inc-rename.enable = lib.mkDefault config.programs.nixvim.plugins.lsp.enable;

  };
}
