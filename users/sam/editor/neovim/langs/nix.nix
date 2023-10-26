{ inputs
, ...
}:
{
  programs.nixvim.plugins = {
    nix.enable = true;

    lsp.servers = {

      nixd = {
        enable = true;
        settings = {
          #eval.depth = 0;                   # Extra depth for evaluation
          #eval.workers = 3;                 # Number of workers for evaluation task
          #eval.target.args = [];            # Accept args as `nix eval`
          #eval.target.installable = "";     # "nix eval"
          formatting.command = "nixpkgs-fmt";
          options.enable = true;            # Enable option completion task. Disable if writing a package
          #options.target.args = [];         # Accept args as `nix eval`
          #options.target.installable = "";  # "nix eval"
        };
      };

      nil_ls = {
        enable = false;
        settings = {
          formatting.command = null;  # External formatter command Options: null | List<str>
        };
      };

      rnix-lsp = {
        enable = false;
      };

    };

    none-ls.sources = {
      code_actions.statix.enable = true;
      diagnostics.deadnix.enable = true;
      diagnostics.statix.enable = true;
      formatting.alejandra.enable = true;
      formatting.nixfmt.enable = false;
      formatting.nixpkgs_fmt.enable = false;
    };

  };
}
