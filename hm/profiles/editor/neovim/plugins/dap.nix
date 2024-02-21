{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [];
  programs.nixvim.plugins.dap = {
    enable = true;
    #package = pkgs.vimPlugins.nvim-dap;
    #extraOptions = {};

    signs = {
      dapBreakpoint.text = "●";
      dapBreakpointCondition.text = "⯑";
      #dapBreakpointRejected.text = "R";
      #dapLogPoint.text="L";
      #dapStopped.text="→";
    };

    extensions = {
      dap-ui = {
        enable = true;
        controls = {
          enabled = true;
          element = "repl"; # Element to show the controls on. Options: repl | scopes | stacks | watches | breakpoints | console
        };
        expandLines = true;
        forceBuffers = true;

        #package = pkgs.vimPlugins.dap-ui;
        #extraOptions = {};
        #selectWindow = null;  # Options: null | str
      };

      dap-virtual-text = {
        enable = true;
        enabledCommands = true;
        allFrames =
          true; # Show virtual text for all stack frames, not just current. Default=false
        allReferences =
          true; # Show virtual text on all references of the variable, not only definitions. Default=false
        clearOnContinue =
          false; # Clear virtual text on continue (may cause flickering when stepping) Default=false
        commented =
          false; # Prefix virtual text w/ comment string. Default=false
        #displayCallback = null;
        highlightChangedVariables =
          true; # HL changed vals w/ `NvimDapVirtualTextChanged`, else always `NvimDapVirtualText`. Default=true
        highlightNewAsChanged = false; # HL new vars same as changed
        onlyFirstDefinition =
          true; # Only show virtual text at 1st definiton if multiple
        showStopReason = true; # Show stop reason when exceptions. Default=true;
        virtLines = false; # Show virtual lines instead of VT
        #virtTextPos = "vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol'";   # Default tries to inline VT. Use 'eol' for end-of-line. See :h nvim_buf_set_extmark().
        #virtTextWinCol = null;    # Position VT @ fixed window col (starting from first text column).
      };
    };
  };
}
