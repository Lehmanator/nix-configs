{ config, pkgs, ... }: {
  plugins = {
    cmp-latex-symbols.enable = config.plugins.cmp.enable;
    lsp.servers.texlab.enable = config.plugins.lsp.enable;
    vimtex.enable = true;
  };
  #home.packages = [pkgs.texlive.combined.scheme-medium]; # -medium|-full
}
