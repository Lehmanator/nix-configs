{ inputs
, config, pkgs
, ...
}:
{
  # --- LaTeX --------------------------
  programs.nixvim.plugins = {
    cmp-latex-symbols.enable = config.programs.nixvim.plugins.nvim-cmp.enable;
    lsp.servers.texlab.enable = config.programs.nixvim.plugins.lsp.enable;
    vimtex.enable = true;
  };
  home.packages = [ pkgs.texlive.combined.scheme-medium ];  #-medium|-full
}

