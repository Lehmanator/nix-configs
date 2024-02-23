{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  program = "eza";
  readable = {
    size = true;
    date = true;
    perms = true;
  };
  sort = {
    dirs = "first";
    field = "name";
    reverse = false;
    ignored = true && show.git;
  };
  view = {
    layout = "grid"; # grid | tree | oneline
    recurse = true;
    depth = 3;
  };
  show = {
    classify = false;
    color = true;
    git = true;
    icons = true;
    headers = true;
    links = true;
    symlinks = true;
    total = true;
  };
in {
  # --- lsd ---
  programs.lsd = {
    enable = true;
    enableAliases = program == "lsd";
    settings = {
      # See: https://github.com/Peltoche/lsd#config-file-content
      blocks = [
        "permission"
        "user"
        "group"
        "size"
        "date"
        "name"
        #"context"
        #"inode"
        #"links"
        (
          if show.git
          then "git"
          else ""
        ) # "git"
      ];
      classic = false;
      color.theme = "default"; # default  | custom (looks for ~/.config/lsd/colors.yaml)
      color.when =
        if show.color
        then "auto"
        else "never"; # always   | auto   | never
      hyperlink =
        if show.links
        then "auto"
        else "never"; # always   | auto   | never
      icons.when =
        if show.icons
        then "auto"
        else "never"; # always   | auto   | never
      icons.theme =
        if show.icons
        then "fancy"
        else "unicode"; # unicode  | fancy
      date =
        if readable.date
        then "relative"
        else "date"; # relative | date   | +<date_format>
      permission =
        if readable.perms
        then "rwx"
        else "octal"; # octal    | rwx
      size =
        if readable.size
        then "short"
        else "default"; # default  | short  | bytes
      recursion.enabled = view.recurse;
      recursion.depth = view.depth;
      layout = view.layout; # grid  | tree | oneline
      sorting.column = sort.field; # name  | time | size    | version
      sorting.dir-grouping = sort.dirs; # first | last | none
      sorting.reverse = sort.reverse;
      indicators = show.classify;
      header = show.headers;
      total-size = show.total; # Show total size of directories. Default=false
      ignore-globs = [".git" ".hg" ".svn"];

      # --- Symlinks ---
      dereference = true; # !show.symlinks;
      no-symlink = !show.symlinks;
      symlink-arrow = "⇒";
    };
  };
}
