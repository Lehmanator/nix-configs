{ inputs, self
, config, lib, pkgs
, ...
}:
let
  prog = "exa";
  readable = {
    size  = true;
    date  = true;
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
    git   = true;
    icons = true;
    headers = true;
    links = true;
    symlinks = true;
    total = true;
  };
in
{
  imports = [
  ];

  # --- Directory Listing -----
  home.shellAliases = {
    l = prog + " -a";
    lt = prog + " --tree";
  };

  # Sort Fields:
  # Exa: accessed, changed, created, e|Extension, inode, modified, n|Name, size, type, none (Caps sort upper before lower)
  # Lsd:                               extension,            time,   name, size, version

  # Time Fields:
  # Exa: modified, changed, accessed, and created
  # Lsd:

  # Exa Time Styles: default, iso, long-iso, full-iso
  # Lsd:

  # Toggle Opts:
  # Exa:  always, never, automatic
  # Lsd:  always, never, auto

  # Blocks:
  # Exa: permissions, size, user, date, name
  # Lsd: permissions, user, group, size, date, name
  # --- exa ---
  programs.exa = let baseOptions = [
    "--group-directories-first"
  ]; in {
    enable = true;
    enableAliases = prog == "exa";
    git = show.git;
    icons = show.icons;
    extraOptions = let base = [
      "--level=${view.depth}"
    ]; in base
      + (if show.header   then "--header"                  else null)
      + (if show.color    then "--color-scale"             else null)
      + (if show.classify then "--classify"                else null)
      + (if sort.dirs     then "--group-directories-first" else null)
      + (if sort.ignored  then "--git-ignore"              else null);
  };

  # --- lsd ---
  programs.lsd = {
    enable = true;
    enableAliases = prog == "lsd";
    settings = {  # See: https://github.com/Peltoche/lsd#config-file-content
      blocks = let base = [
        "permission"
        "user"
        "group"
        "size"
        "date"
        "name"
        #"context"
        #"inode"
        #"links"
        #"git"
      ]; in base
        + (if show.git then "git" else null);
      classic     = false;
      color.theme = "default";                                            # default  | custom (looks for ~/.config/lsd/colors.yaml)
      color.when  = if show.color     then "auto"       else "never";     # always   | auto   | never
      hyperlink   = if show.links     then "auto"       else "never";     # always   | auto   | never
      icons.when  = if show.icons     then "auto"       else "never";     # always   | auto   | never
      icons.theme = if show.icons     then "fancy"      else "unicode";   # unicode  | fancy
      date        = if readable.date  then "relative"   else "date";      # relative | date   | +<date_format>
      permission  = if readable.perms then "rwx"        else "octal";     # octal    | rwx
      size        = if readable.size  then "short"      else "default";   # default  | short  | bytes
      layout               = view.layout;     # grid  | tree | oneline
      sorting.column       = sort.field;      # name  | time | size    | version
      sorting.dir-grouping = sort.dirs;       # first | last | none
      sorting.reverse      = sort.reverse;
      recursion.enabled    = sort.recursion;
      recursion.depth      = sort.depth;
      indicators           = show.classify;
      header               = show.headers;
      total-size           = show.total;  # Show total size of directories. Default=false
      ignore-globs = [ ".git" ".hg" ".svn" ];

      # --- Symlinks ---
      dereference = true; #!show.symlinks;
      no-symlink = !show.symlinks;
      symlink-arrow = "⇒";
    };
  };
}
