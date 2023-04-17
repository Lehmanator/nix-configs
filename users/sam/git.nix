{
  config, lib, pkgs,
  ...
}:
{
  imports = [

  ];

  programs.git.enable = true;
  programs.git.package = pkgs.gitAndTools.gitFull;
  programs.git.aliases = {
    a = "add";
    aa = "add --all";
    b = "branch";
    bi = "bisect";
    br = "branch";
    bug = "bugreport";
    checko = "checkout";
    chko = "checkout";
    cl = "clone";
    clo = "clone";
    cle = "clean";
    cm = "commit -m";
    cfg = "config";
    cfgg = "config --global";
    d = "diff";
    f = "fetch";
    h = "help";
    i = "init";
    ls = "ls-files";
    m = "merge";
    p = "pull";
    pu = "pull;";
    pul = "pull";
    po = "push origin";
    pod = "push origin develop";
    pom = "push origin main";
    pus = "push";
    pushd = "push origin develop";
    pushm = "push origin main";
    reb = "rebase";
    req = "request-pull";
    res = "reset";
    rest = "restore";
    rev = "revert";
    s = "status";
    sh = "show";
    slog = "shortlog";
    sub = "submodule";
    wchg = "whatchanged";
    what = "whatchanged";
  };
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
  programs.git.extraConfig = {
    core.whitespace = "trailing-space,space-before-tab";
    init.defaultBranch = "main";
    pull.rebase = false;
    url = {
      "git@github.com" = {
        insteadOf = "https://github.com";
      };
    };
  };
  #programs.git.hooks = {
  #  pre-commit = ./pre-commit-script;
  #}
  programs.git.ignores = [
    "*~"
    "*.swp" "*.swo"
    "*.key" "*.privkey" "*.luks" "*.lukskey" "*.privatekey" "*.p7" "*.p11" "*.psk" "*.pkcs"
    "*.cert" "*.crt" "*.pem"
    "*.o" "*.log"
  ];
  programs.git.includes = [
    # { path = "~/path/to/config.inc"; }
    # {
    #   path = "~/path/to/conditional.inc";
    #   condition = "gitdir:~/src/dir";
    # }
  ];
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
