
{ inputs
, ...
}:
{
  programs.nixvim.plugins.gitsigns = {
    enable = true;
    currentLineBlame = true;
    currentLineBlameOpts = {
      virtTextPos = "eol"; # eol | overlay | right_align
    };
    numhl = false; # Enable line number highlights
    showDeleted = false; # Show old version of hunks inline via virtual lines
    signcolumn = true;
    trouble = true; # Use Trouble instead of QuickFix/LocationList window for setqflist()/setloclist()
    watchGitDir = {
      enable = true;
      followFiles = true; # Switch to new location after `git mv`
    };
    wordDiff = true; # Requires `diff_opts.internal = true`
  };
}
