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
    rust-tools.enable = true;
    lsp.servers.rust-analyzer = {
      enable = true;
      installCargo = true;
      installRustc = true;
      #cargoPackage = pkgs.cargo;
      #rustcPackage = pkgs.rustc;
    };
  };
}
