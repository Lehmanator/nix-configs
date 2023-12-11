{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./aliases.nix
    ./diff.nix
    ./fzf.nix
    ./gh.nix
    ./gitui.nix
    ./hooks.nix
    ./ignore.nix
    ./includes.nix
    ./mr.nix
    #./sync.nix
    ./tui.nix
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    # https://git-scm.com/docs/git-config
    extraConfig = {
      core.whitespace = "trailing-space,space-before-tab";
      column.ui = "auto,column,dense";
      init.defaultBranch = "main";
      pull.rebase = false;
      status.submoduleSummary = true;
      url."git@github.com:".pushInsteadOf = "https://github.com/";
      url."git@gitlab.com:".pushInsteadOf = "https://gitlab.com/";

      #core.autocrlf = true;  # Fix Windows: CR + LF  ->  LF  (input="fix CRLF on add", true="convert on add/checkout")
      #core.askPass = "";
      #merge.autoStash = true;
      #web.browser = "";
    };

    lfs.enable = true;

    #signing.signByDefault = true;
    #userEmail = "";
    #userName = "";
  };

}
