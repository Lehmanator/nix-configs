{ inputs
, ...
}:
{
  programs.nixvim.plugins = {
    lsp.servers = {
      nixd.enable = true;
      nil_ls.enable = false;
      rnix-lsp.enable = false;
    };
    nix.enable = true;
    null-ls.sources = {
      code_actions.statix.enable = true;
      diagnostics = {
        deadnix.enable = true;
        statix.enable = true;
      };
      formatting = {
        alejandra.enable = true;
        nixfmt.enable = false;
        nixpkgs_fmt.enable = false;
      };
    };
  };
}
