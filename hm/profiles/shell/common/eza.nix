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
      "--hyperlink"
      (
        if show.headers
        then "--header"
        else " "
      )
      #(
      #  if show.color
      #  then "--color-scale=gradient"
      #  else ""
      #)
      #(if show.classify then "--classify"                else "")
      (
        if sort.ignored
        then "--git-ignore"
        else ""
      )
      (
        if sort.dirs == "first"
        then "--group-directories-first"
        else ""
      )
    ];
  };
}
