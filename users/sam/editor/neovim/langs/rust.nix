{ inputs
, pkgs
, ...
}:
{
  imports = [
  ];

  programs.nixvim.plugins = {
    cmp-clippy.enable = true;
    crates-nvim.enable = true;
    lsp.servers.rust-analyzer.enable = true;
    rust-tools.enable = true;
  };
}
