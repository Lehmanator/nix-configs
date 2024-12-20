{ lib, pkgs, ... }:
# TODO: Create separate nixosModule / hmModule with these options.
# - Use option values to set config for all ls programs. `programs.ls = {}`
# - Use `programs.ls.alias="eza"` to set `programs.eza.enableAliases=true`
let
  inherit (lib) optional;
  sort = {
    dirs    = "first";
    field   = "name";
    reverse = false;
    ignored = false && show.git;
  };
  view = {
    layout  = "grid"; # grid | tree | oneline
    recurse = true;
    depth   = 3;
  };
  show = {
    classify  = false;
    color     = true;
    git       = true;
    icons     = true;
    headers   = true;
    links     = true;
    symlinks  = true;
    total     = true;
    hyperlink = true;
  };
in {
  programs.eza = {
    enable = true;
    icons = "auto";
    inherit (show) git;

    # TODO: Use lib.cli.toGNUCommandLine {} attrs;
    extraOptions =
      ["--level=${builtins.toString view.depth}"]
      ++ optional show.hyperlink "--hyperlink"
      ++ optional show.headers   "--header"
      ++ optional sort.ignored   "--git-ignore"
      ++ optional (sort.dirs=="first") "--group-directories-first"
      #++ lib.optional classify "--classify"
      #++ lib.optional color "--color-scale=gradient"
      ;
  };
}
#readable = { size = true; date = true; perms = true; };
# --- Sort Fields ---
# eza: accessed, changed, created, e|Extension, inode, modified, n|Name, size, type, none (Caps sort upper before lower)
# lsd:                               extension,            time,   name, size, version
# --- Time Fields ---
# eza: modified, changed, accessed, and created
# lsd:
# --- Time Styles ---
# eza: default, iso, long-iso, full-iso
# lsd:
# --- Toggle Opts ---
# exa:  always, never, automatic
# lsd:  always, never, auto
# --- Blocks ---
# exa: permissions, size, user, date, name
# lsd: permissions, user, group, size, date, name
# pls:
