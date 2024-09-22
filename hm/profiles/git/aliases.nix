{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
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
    l = "log --oneline --stat --graph";
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
