{
  inputs,
  lib,
  ...
}: {
  plugins = {
    nix.enable = true;

    lsp.servers = {
      nixd = {
        enable = lib.mkDefault false;
        settings = {
          #eval.depth = 0;                   # Extra depth for evaluation
          #eval.workers = 3;                 # Number of workers for evaluation task
          #eval.target.args = [];            # Accept args as `nix eval`
          #eval.target.installable = "";     # "nix eval"
          formatting.command = "nixpkgs-fmt";
          options.enable =
            true; # Enable option completion task. Disable if writing a package
          #options.target.args = [];         # Accept args as `nix eval`
          #options.target.installable = "";  # "nix eval"
        };
      };

      nil_ls = {
        enable = lib.mkDefault true;
        #settings = {
        #  formatting.command = null;  # External formatter command Options: null | List<str>
        #};
      };

      rnix-lsp = {enable = lib.mkDefault false;};
    };

    none-ls.sources = {
      code_actions = {statix.enable = lib.mkDefault true;};
      diagnostics = {
        deadnix.enable = lib.mkDefault true;
        statix.enable = lib.mkDefault true;
      };
      formatting = {
        alejandra.enable = lib.mkDefault true;
        nixfmt.enable = lib.mkDefault true;
        nixpkgs_fmt.enable = lib.mkDefault true;
      };
    };
  };
}
