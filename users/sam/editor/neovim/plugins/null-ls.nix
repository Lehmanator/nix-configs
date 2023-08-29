{ inputs
, lib, pkgs, config
, ...
}:
{
  # --- null-ls ----------------------
  # Integrate external sources with native nvim LSP
  programs.nixvim.plugins.null-ls = {
    enable = true;
    border = lib.mkDefault "rounded"; # none|single|double|rounded|solid|shadow

    #diagnosticConfig = {};

    # User-defined function(buffer_number) that controls whether to enable null-ls for buffer.
    #shouldAttach = "";

    sources = {
      code_actions = {
        gitsigns.enable = true;
        shellcheck.enable = true;
      };
      diagnostics = {
        cppcheck.enable = true;
        gitlint.enable = true;
        shellcheck.enable = true;
      };
      formatting = {
        cbfmt.enable = true;
        fnlfmt.enable = true;
        fourmolu.enable = true;
        phpcbf.enable = true;
        prettier.enable = true;
        shfmt.enable = true;
        stylua.enable = true;
        taplo.enable = true;
      };
    };
  };
}
