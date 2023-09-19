{ inputs, self
, config, lib, pkgs
, ...
}:
let
  program = "eza";
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
    l = "${program} -a";
    lt = "${program} --tree";
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
  # --- eza ---
  programs.eza = {
    enable = true;
    enableAliases = program == "eza";
    git = show.git;
    icons = show.icons;
    extraOptions = [
      "--level=${builtins.toString view.depth}"
      (if show.headers  then "--header"                  else " ")
      (if show.color    then "--color-scale"             else "")
      #(if show.classify then "--classify"                else "")
      (if sort.ignored  then "--git-ignore"              else "")
      (if sort.dirs == "first" then "--group-directories-first" else "")
    ];
  };

  # --- lsd ---
  programs.lsd = {
    enable = true;
    enableAliases = program == "lsd";
    settings = {  # See: https://github.com/Peltoche/lsd#config-file-content
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
        (if show.git then "git" else "") #"git"
      ];
      classic     = false;
      color.theme = "default";                                            # default  | custom (looks for ~/.config/lsd/colors.yaml)
      color.when  = if show.color     then "auto"       else "never";     # always   | auto   | never
      hyperlink   = if show.links     then "auto"       else "never";     # always   | auto   | never
      icons.when  = if show.icons     then "auto"       else "never";     # always   | auto   | never
      icons.theme = if show.icons     then "fancy"      else "unicode";   # unicode  | fancy
      date        = if readable.date  then "relative"   else "date";      # relative | date   | +<date_format>
      permission  = if readable.perms then "rwx"        else "octal";     # octal    | rwx
      size        = if readable.size  then "short"      else "default";   # default  | short  | bytes
      recursion.enabled    = view.recurse;
      recursion.depth      = view.depth;
      layout               = view.layout;     # grid  | tree | oneline
      sorting.column       = sort.field;      # name  | time | size    | version
      sorting.dir-grouping = sort.dirs;       # first | last | none
      sorting.reverse      = sort.reverse;
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
