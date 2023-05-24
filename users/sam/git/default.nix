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

  programs.git.enable = true;
  programs.git.package = pkgs.gitAndTools.gitFull;
  programs.git.delta = {
    enable = true;
    options = {
      #decorations = {
      #  commit-decoration-style = "bold yellow box ul";
      #  file-decoration-style = "none";
      #  file-style = "bold yellow ul";
      #};
      features = "decorations";
      #whitespace-error-style = "22 reverse";
    };
  };

  # https://git-scm.com/docs/git-config
  programs.git.extraConfig = {
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

  programs.git.lfs.enable = true;
  #programs.git.signing = { signByDefault = true; };
  #programs.git.userEmail = "";
  #programs.git.userName = "";
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

  home.shellAliases = {
    g = "git";
    gs = "git status";
    ga = "git add";
    Ga = "git add !$";
    gaa = "git add --all";
    gb = "git branch";
    gc = "git commit -m";
    gcm = "git commit -m";
    gco = "git checkout";
    gcl = "git clone";
    gi = "git init";
    gl = "git log";
    gmv = "git mv";
    grm = "git rm";

    add = "git add";
    Add = "git add !$";
    amend = "git commit --amend";
    branch = "git branch";
    checkout = "git checkout";
    commit = "git commit -m";
    fetch = "git fetch";
    merge = "git merge";
    pull = "git pull";
    push = "git push";
    rebase = "git rebase";
    reset = "git reset";
    restore = "git restore";
    revert = "git revert";
    stash = "git stash";
    status = "git status";
    submodule = "git submodule";
  };
}
