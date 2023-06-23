{ inputs
, ...
}:
{
  programs.nixvim.plugins = {
    lsp.servers.pylsp = {
      enable = true;
      settings.configurationSources = "flake8";
      settings.plugins = {
        autopep8.enabled = true;
        black.enabled = true;
        black.preview = true;
        flake8.enabled = true;
        pycodestyle.enabled = true;
        pydocstyle.enabled = true;
        pyflakes.enabled = true;
        pylint.enabled = true;
        pylsp_mypy.enabled = true;
        rope.enabled = true;
      };
    };
    null-ls.sources = {
      code_actions.statix.enable = true;
      diagnostics.flake8.enable = true;
      formatting.black.enable = true;
    };
  };
}
