{
  lib,
  pkgs,
  config,
  ...
}: {
  # --- null-ls ----------------------
  # Integrate external sources with native nvim LSP
  programs.nixvim.plugins.none-ls = {
    enable = true;
    enableLspFormat = true;
    #border = lib.mkDefault "rounded"; # none|single|double|rounded|solid|shadow

    diagnosticConfig = {virtual_text = true;};

    # User-defined function(buffer_number) that controls whether to enable null-ls for buffer.
    #shouldAttach = "";
    updateInInsert = false;

    sources = {
      completion = {
        luasnip.enable = true;
        spell.enable = true;
        tags.enable = true;
      };
      code_actions = {
        gitrebase.enable = true;
        gitsigns.enable = true;
        gomodifytags.enable = true;
        impl.enable = true;
        proselint.enable = true;
        refactoring.enable = true;
        statix.enable = true;
        ts_node_action.enable = true;
      };
      diagnostics = {
        actionlint.enable = true;
        alex.enable = true;
        ansiblelint.enable = true;
        bslint.enable = true;
        buf.enable = true;
        buildifier.enable = true;
        cfn_lint.enable = true;
        checkmake.enable = true;
        checkstyle.enable = true;
        clazy.enable = true;
        clj_kondo.enable = true;
        cmake_lint.enable = true;
        codespell.enable = true;
        commitlint.enable = true;
        cppcheck.enable = true;
        credo.enable = true;
        cue_fmt.enable = true;
        deadnix.enable = false;
        djlint.enable = false;
        dotenv_linter.enable = false;
        editorconfig_checker.enable = true;
        erb_lint.enable = true;
        fish.enable = true;
        gccdiag.enable = true;
        gdlint.enable = true;
        gitlint.enable = true;
        glslc.enable = true;
        golangci_lint.enable = true;
        ktlint.enable = true;
        ltrs.enable = true;
        markdownlint.enable = true;
        markdownlint_cli2.enable = false;
        markuplint.enable = false;
        mdl.enable = false;
        mlint.enable = false;
        mypy.enable = false;
        proselint.enable = true;
        pylint.enable = true;
        rstcheck.enable = true;
        semgrep.enable = true;
        sqlfluff.enable = true;
        staticcheck.enable = true;
        statix.enable = true;
        stylelint.enable = false;
        stylint.enable = false;
        terraform_validate.enable = true;
        textlint.enable = false;
        tfsec.enable = false;
        todo_comments.enable = false;
        trail_space.enable = true;
        write_good.enable = false;
        yamllint.enable = true;
        zsh.enable = true;
      };
      formatting = {
        alejandra.enable = true;
        asmfmt.enable = true;
        black.enable = true;
        blackd.enable = false;
        buf.enable = true;
        buildifier.enable = true;
        cbfmt.enable = true;
        erb_format.enable = true;
        erb_lint.enable = true;
        erlfmt.enable = true;
        findent.enable = false;
        fnlfmt.enable = true;
        gofmt.enable = true;
        goimports.enable = true;
        golines.enable = true;
        hclfmt.enable = true;
        htmlbeautifier.enable = true;
        isort.enable = true;
        ktlint.enable = true;
        markdownlint.enable = true;
        mdformat.enable = false;
        mix.enable = true;
        nginx_beautifier.enable = true;
        nixfmt.enable = true;
        nixpkgs_fmt.enable = true;
        packer.enable = true;
        phpcbf.enable = true;
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
        };
        prettierd.enable = false;
        protolint.enable = false;
        pyink.enable = false;
        remark.enable = true;
        rustywind.enable = true;
        shellharden.enable = true;
        shfmt.enable = true;
        sqlfluff.enable = false; # 1/15/23: fail dep=python3.11-diff-cover-8.0.1
        sqlfmt.enable = true;
        sqlformat.enable = false;
        stylelint.enable = false;
        styler.enable = false;
        stylua.enable = true;
        terraform_fmt.enable = true;
        textlint.enable = false;
        tidy.enable = false;
        topiary.enable = false;
        treefmt.enable = true;
        usort.enable = false;
        yamlfix.enable = true;
        yamlfmt.enable = false;
        zprint.enable = true;
        fantomas.enable = false;
        fantomas.package = null;
      };
      hover = {
        dictionary.enable = true;
        printenv.enable = true;
      };
    };
  };
  programs.nixvim.extraConfigVim = ''
    sign define DiagnosticSignError text=✘ texthl=DiagnosticSignError linehl= numhl=
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
  '';
}
