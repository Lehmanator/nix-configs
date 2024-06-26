{
  config,
  lib,
  pkgs,
  ...
}:
# TODO: Pick between either gutter signs or line highlighting.
{
  programs.nixvim = {
    options.cursorlineopt = "both";
    highlight = {
      #GitSignsStagedAdd = { fg = ""; bg = ""; };
      #GitSignsAdd = { fg = ""; bg = ""; };
      #GitSignsAddPreview = { fg = ""; bg = ""; };
      #GitSignsAddInline = { fg = ""; bg = ""; };
      #GitSignsAddLn = { fg = ""; bg = ""; };
      #GitSignsAddLnInline = { fg = ""; bg = ""; };
      GitSignsAddNr = {
        #fg = "";
        fg = "Green";
        blend = 50;
        bold = true;
      };
      #GitSignsChangeLn = { fg = ""; bg = ""; };
      GitSignsChangeNr = {
        fg = "White";
        blend = 50;
        bold = true;
      };
      GitSignsDeleteNr = {
        fg = "Red";
        blend = 50;
        bold = true;
      };
    };

    plugins.gitsigns = {
      inherit (config.programs.git) enable;
      #package = pkgs.vimPlugins.gitsigns;
      gitPackage = config.programs.git.package;

      settings = {
        attachToUntracked = true; # Attach to untracked files. D=t
        #base = null;                 # Git object/revision to diff against. D='index'
        #countChars = {"1"="1";};    # Chars for counts when signs.*.show_count=true. + entry used as fallback.

        currentLineBlame = true;
        currentLineBlameOpts = {
          delay = 1000; # Delay (ms) before virt text displayed. D=1000
          ignoreWhitespace = true; # Ignore whitespace when running blame. D=f
          virtTextPos = "right_align"; # *eol | overlay | right_align
          virtTextPriority = 100; # Opts: null | int                    . D=100
        };

        diffOpts = {
          algorithm = "myers"; # myers | minimal | patience | histogram
          indentHeuristic =
            false; # Use the indent heuristic for the internal diff library
          internal =
            true; # Use Neovim's builtin xdiff library for running diffs
          #linematch = null;        # Enable second-stage diff on hunks to align lines. null | int
          vertical = true; # Start diff mode w/ vertical splits
        };

        linehl = false; # Enable highlighting lines by diff
        numhl = true; # Enable line number highlights

        showDeleted =
          false; # Show old version of hunks inline via virtual lines
        signPriority = 6;
        signcolumn = false;

        signs = {
          add = {
            hl = "GitSignsAdd";
            text = "┃";
            numhl = "GitSignsAddNr";
            linehl = "GitSignsAddLn";
          };
          change = {
            hl = "GitSignsChange";
            linehl = "GitSignsChangeLn";
            numhl = "GitSignsChangeNr";
          };
          #delete = {};
          #topdelete = {};
          #changedelete = {};
          #untracked = {};
        };

        # Use Trouble instead of QuickFix/LocationList window for setqflist()/setloclist()
        trouble = config.programs.nixvim.plugins.trouble.enable;

        watchGitDir = {
          enable = true;
          followFiles = true; # Switch to new location after `git mv`
        };

        wordDiff = true; # Requires `diff_opts.internal = true`

        #yadm = false;         # YADM support. D=f
      };
    };
  };
}
