{ config, lib, pkgs, ... }: {
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

  # https://wiki.nixos.org/wiki/Git
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;

    # https://git-scm.com/docs/git-config
    # https://git-scm.com/docs/git-config#Documentation/git-config.txt-pushautoSetupRemote
    extraConfig = {
      branch = {
        autoSetupRebase = "always";
      };
      color = {
        ui = "always";
      };
      core = {
        #core.autocrlf = true;  # Fix Windows: CR + LF  ->  LF  (input="fix CRLF on add", true="convert on add/checkout")
        autocrlf = false;
        whitespace = "trailing-space,space-before-tab";
      };
      column.ui = "auto,column,dense";
      credential = {
        # By default, Git does not consider the "path" component of an http URL to be worth matching via external helpers.
        # This means that a credential stored for https://example.com/foo.git will also be used for https://example.com/bar.git.
        # If you do want to distinguish these cases, set this option to true.
        useHttpPath = true;

        # helper = "${pkgs.git.override {withLibsecret = true;}}/bin/git-credential-libsecret";
        helper = "${config.programs.git.package}/bin/git-credential-libsecret";
      };
      init.defaultBranch = "main";
      pull.rebase = false;
      push.autoSetupRemote = true;
      status.submoduleSummary = true;
      url."git@github.com:".pushInsteadOf = "https://github.com/";
      url."git@gitlab.com:".pushInsteadOf = "https://gitlab.com/";

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

  home.packages = [
    pkgs.git-credential-oauth
    pkgs.git-credential-keepassxc
    pkgs.git-credential-gopass
    pkgs.pass-git-helper
    pkgs.gitoxide
  ];
}
