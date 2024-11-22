{ config, lib, pkgs, ... }:
# https://github.com/helix-editor/helix/wiki/Language-Server-Configurations#rust
{
  programs.helix = {
    extraPackages = [
      pkgs.rust-analyzer
      pkgs.rustfmt
      pkgs.rustup
    ];
    languages = {
      language-server.rust-analyzer = {
        # https://rust-analyzer.github.io/manual.html
        config = {
          check.command = "clippy";
          cargo = {
            features = "all";
          };
        };
      };
      language = [{
        name = "rust";
        auto-format = true;
        formatter = { 
          command = "rustfmt";
          # args = ["+nightly"];
        };
      }];
    };
  };
}
