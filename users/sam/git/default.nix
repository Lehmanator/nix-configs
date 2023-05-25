{ config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./aliases.nix
    ./hooks.nix
    ./includes.nix
    ./ignore.nix
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    delta = {
      enable = true;
      options = {
        #decorations = {
        #  commit-decoration-style = "bold yellow box ul";
        #  file-decoration-style = "none";
        #  file-style = "bold yellow ul";
        #};
        #features = "decorations";
        #whitespace-error-style = "22 reverse";
      };
    };

    # https://git-scm.com/docs/git-config
    extraConfig = {
      core = {
        #autocrlf = true;  # Fix Windows: CR + LF  ->  LF  (input="fix CRLF on add", true="convert on add/checkout")
        whitespace = "trailing-space,space-before-tab";
        #askPass = "";
      };
      column.ui = "auto,column,dense";
      init.defaultBranch = "main";
      #merge.autoStash = true;
      pull.rebase = false;
      status = {
        submoduleSummary = true;
      };
      url = {
        "git@github.com:" = {
          pushInsteadOf = "https://github.com/";
        };
        "git@gitlab.com:".pushInsteadOf = "https://gitlab.com/";
      };
      #web.browser = "";
    };

    lfs.enable = true;
    #signing = { signByDefault = true; };
    #userEmail = "";
    #userName = "";
  };

  programs.gitui = {
    enable = true;
    #theme = ''
    #'';
  };

  # https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md
  programs.lazygit = {
    enable = false;
    settings = {
      gui.showIcons = true;
    };
  };
}
