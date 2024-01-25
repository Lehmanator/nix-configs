{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./aliases.nix
    ./diff.nix
    ./fzf.nix
    ./gh.nix
    ./gitui.nix
    ./hooks.nix
    ./ignore.nix
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
      push.autoSetupRemote = true;
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

    includes = [
      #(import ./users/public.nix)
      #(import ./users/personal.nix)
      #(import ./users/gnome.nix)
      #(import ./users/gaming.nix)
      #(import ./users/work.nix)
      # { path = "~/path/to/config.inc"; }
      # { path = "~/path/to/conditional.inc";
      #   condition = "gitdir:~/src/dir";
      # }
    ];
  };
}
