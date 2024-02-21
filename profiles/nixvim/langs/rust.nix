{pkgs, ...}: {
  plugins = {
    cmp-clippy.enable = true;
    crates-nvim.enable = true;
    rust-tools = {
      enable = true;
      crateGraph = {
        enabledGraphvizBackends = ["dot" "jpg" "json" "pdf" "plain-ext" "png" "svg" "webp" "x11"];
        backend = "svg";
      };
      server.cargo.features = "all";
    };
    lsp.servers.rust-analyzer = {
      enable = true;
      installCargo = true;
      installRustc = true;
      #cargoPackage = pkgs.cargo;
      #rustcPackage = pkgs.rustc;
    };
  };
}
