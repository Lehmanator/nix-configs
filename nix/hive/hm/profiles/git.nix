{ cell, config, lib, pkgs, ... }: {
  imports = [
    cell.homeProfiles.gh
    cell.homeProfiles.git-aliases
    cell.homeProfiles.git-diff
    cell.homeProfiles.git-fzf
    cell.homeProfiles.git-hooks
    cell.homeProfiles.git-mr
    cell.homeProfiles.git-sync
    cell.homeProfiles.git-tui
    cell.homeProfiles.gitignore
    cell.homeProfiles.gitui
  ];

  # https://nixos.wiki/wiki/Git
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    # https://git-scm.com/docs/git-config
    # https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushautoSetupRemote
    extraConfig = {
      core.whitespace = "trailing-space,space-before-tab";
      column.ui = "auto,column,dense";
      credential.helper = "${
        config.programs.git.package.override {withLibsecret = true;}
      }/bin/git-credential-libsecret";
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
