{ inputs
, ...
}:
{
  programs.nixvim.plugins = {
    dap.extensions.dap-python = {
      enable = true;
      #package = pkgs.vimPlugins.nvim-dap-python;
      #adapterPythonPath = "/nix/store/...-python3-3.10.12/bin/python3";  # Path to python interpretter. Path must be absolute or in $PATH & must have debugpy package installed.
      console = "integratedTerminal";  # integratedTerminal | internalConsole | externalTerminal
      includeConfigs = true;
      #resolvePython = null;            # Fn to resolve path to python to use for execution. By default use VIRTUAL_ENV | CONDA_PREFIX if present.
      #testRunner = null;               # Name of test runner to use by default. Default is dynamic & depends on pytest.ini or manage.py markers. If neither found, use 'unittest'
      #testRunners = null;              # Set to register test runners. Built-ins: unittest|pytest|django. Attr keys are test runner names, vals are funcs to generate the module name to run & its args. See: |dap-python.TestRunner|
    };

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
