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
}
