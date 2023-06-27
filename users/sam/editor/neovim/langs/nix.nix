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
      diagnostics.deadnix.enable = true;
      diagnostics.statix.enable = true;
      formatting.alejandra.enable = true;
      formatting.nixfmt.enable = false;
      formatting.nixpkgs_fmt.enable = false;
    };
  };
}
