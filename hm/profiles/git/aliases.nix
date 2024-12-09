{ inputs, config, lib, pkgs, ... }:
let
  gix = "${pkgs.gitoxide}/bin/gitoxide";
  thicket = lib.getExe pkgs.thicket;
  # meteor = lib.getExe pkgs.meteor-git;
in
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

    cle = "clean";
    cfg = "config";
    cfgg = "config --global";
    d = "diff";

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

    # --- External Tools -----------------------------------
    # > [!NOTE]: External tool commands must be prefixed w/ !
    #
    # --- gh - GitHub CLI ---
    # --- Gitoxide - Rust Git CLI ---
    cl = "!${gix} clone";
    clo = "!${gix} clone";
    # clo = "clone";
    # f = "fetch";
    f = "!${gix} fetch";

    # --- Meteor - Conventional Commits command ---
    # https://github.com/stefanlogue/meteor
    # > [!NOTE] Not available until 24.11
    # TODO: Write config files.
    cm = "commit -m";
    # com = "!${lib.getExe pkgs.meteor-git}";

    # --- Thicket - Better oneline Git log graphs ---
    # l = "log --oneline --stat --graph";
    l    = "!${thicket} --all";
    logg = "!${thicket} --all";

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
    gi = "git init";
    gmv = "git mv";
    grm = "git rm";

    add = "git add";
    Add = "git add !$";
    amend = "git commit --amend";
    branch = "git branch";
    checkout = "git checkout";

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


    # --- External Tools -----------------------------------
    # TODO: gitnr - git ignore file TUI
    gcl = "gix clone";
    fetch = "gix fetch";
    gl = "git l";

    # --- Meteor - Conventional Commits command ---
    # https://github.com/stefanlogue/meteor
    # > [!NOTE] Not available until 24.11
    commit = "git commit -m";
    # commit = "${lib.getExe pkgs.meteor-git}";
  };

}
