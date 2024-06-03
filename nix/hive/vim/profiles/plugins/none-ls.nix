{ lib, pkgs, config, ... }: {
  # --- null-ls ----------------------
  # Integrate external sources with native nvim LSP
  plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    #border = lib.mkDefault "rounded"; # none|single|double|rounded|solid|shadow

    diagnosticConfig = { virtual_text = true; };

    # User-defined function(buffer_number) that controls whether to enable null-ls for buffer.
    #shouldAttach = "";
    updateInInsert = false;

    sources = {
      code_actions = {
        #eslint.enable = true;
        #eslint_d.enable = true;
        gitsigns.enable = true;
        #shellcheck.enable = true;
        statix.enable = true;
      };
      diagnostics = {
        alex.enable = true;
        ansiblelint.enable = true;
        cppcheck.enable = true;
        deadnix.enable = false;
        #eslint.enable = true;
        #eslint_d.enable = true;
        #flake8.enable = true;
        gitlint.enable = true;
        # golangci_lint.enable = true; # Broken: 2024-05-28
        ktlint.enable = true;
        #luacheck.enable = true;
        markdownlint.enable = true;
        pylint.enable = true;
        #shellcheck.enable = true;
        staticcheck.enable = true;
        statix.enable = true;
        write_good.enable = true;
        yamllint.enable = true;
      };
      formatting = {
        alejandra.enable = true;
        #beautysh.enable = true;
        #black.enable = true;
        #cbfmt.enable = true;
        ##eslint.enable = true;
        ##eslint_d.enable = true;
        #fnlfmt.enable = true;
        ##fourmolu.enable = true;
        # gofmt.enable = true;
        # goimports.enable = true;
        # golines.enable = true;
        isort.enable = true;
        ##jq.enable = true;
        ktlint.enable = true;
        markdownlint.enable = true;
        nixfmt.enable = true;
        nixpkgs_fmt.enable = true;
        #phpcbf.enable = true;
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
        };
        ##rustfmt.enable = true;
        shfmt.enable = true;
        ##sqlfluff.enable=true; # Broken as of 1/15/23: failing dep=python3.11-diff-cover-8.0.1
        stylua.enable = true;
        ##taplo.enable = true;
        ##trim_newlines.enable = true;
        #trim_whitespace.enable = true;
        #fantomas.enable = false;
        #fantomas.package = null;
      };
    };
  };

  # TODO: Move to ../styles/icons.nix
  extraConfigVim = ''
    sign define DiagnosticSignError text=✘ texthl=DiagnosticSignError linehl= numhl=
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
  '';
}
