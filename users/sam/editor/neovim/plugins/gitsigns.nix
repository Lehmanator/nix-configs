
{ inputs, self
, config, lib, pkgs
, ...
}:
{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    #package = pkgs.vimPlugins.gitsigns;

    attachToUntracked = true;    # Attach to untracked files. D=t
    #base = null;                 # Git object/revision to diff against. D='index'
    #countChars = {"1"="1";};    # Chars for counts when signs.*.show_count=true. + entry used as fallback.

    currentLineBlame = true;
    currentLineBlameOpts = {
      delay = 1000;              # Delay in ms before blame virtual text is displayed. D=1000
      ignoreWhitespace = true;   # Ignore whitespace when running blame. D=f
      virtTextPos = "eol";       # Opts: eol | overlay | right_align
      virtTextPriority = 100;    # Opts: null | int                    . D=100
    };

    diffOpts = {
      algorithm = "myers";      # myers | minimal | patience | histogram
      indentHeuristic = false;  # Use the indent heuristic for the internal diff library
      internal = true;          # Use Neovim's builtin xdiff library for running diffs
      #linematch = null;        # Enable second-stage diff on hunks to align lines. null | int
      vertical = true;          # Start diff mode w/ vertical splits
    };

    linehl = false;       # Enable highlighting lines by diff
    numhl = true;         # Enable line number highlights

    showDeleted = false;  # Show old version of hunks inline via virtual lines
    signPriority = 6;
    signcolumn = true;
    trouble = config.programs.nixvim.plugins.trouble.enable; # Use Trouble instead of QuickFix/LocationList window for setqflist()/setloclist()

    watchGitDir = {
      enable = true;
      followFiles = true; # Switch to new location after `git mv`
      interval = 2000;    # ms b/w polls of the gitdir. D=1000
    };

    wordDiff = true;      # Requires `diff_opts.internal = true`

    #yadm = false;         # YADM support. D=f
  };

}

