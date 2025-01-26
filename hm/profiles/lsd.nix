{...}: {
  programs.lsd = {
    enable = true;
    enableAliases = false;

    # https://github.com/lsd-rs/lsd/tree/v1.0.0#color-theme-file-content
    # colors = { };

    # https://github.com/Peltoche/lsd#config-file-content
    settings = {
      classic = false;

      # https://github.com/lsd-rs/lsd#configuration
      # Color theme options:
      # - default (use LS_COLORS or builtin defaults)
      # - custom  (use ~/.config/lsd/colors.yaml)
      # - <name>  (use ~/.config/lsd/themes/<name>.yaml)
      color.theme = "default";
      color.when = "always";

      # date: relative | date | +<date_format>
      date = "relative";

      dereference = false;
      header = true;
      hyperlink = "auto";

      # https://github.com/lsd-rs/lsd#icon-theme-file-content
      # https://github.com/lsd-rs/lsd/blob/master/src/theme/icon.rs
      # theme: fancy | unicode;
      icons = {
        when = "auto";
        theme = "fancy";
        separator = " ";
      };

      ignore-globs = [".git" ".hg" ".svn"];
      indicators = false;

      # layout: grid  | tree | oneline
      # layout = "grid";

      no-symlink = false;

      # permission: octal | rwx
      permission = "octal";

      recursion = {
        enabled = false;
        depth = 3;
      };

      # size: default | short | bytes
      size = "short";

      # --- Sorting ---
      # column: extension | name | size | time | version
      # grouping:   first | last | none
      sorting = {
        column = "name";
        dir-grouping = "first";
        reverse = false;
      };

      symlink-arrow = "⇒";

      # Show total size of directories. Default=false
      total-size = true;

      # --- Field Order ---
      # Options: context | date | git | group | inode | links | name | permission | size
      blocks = let
        # Defaults used by lsd
        default = ["permission" "user" "group" "size" "git" "name" "date"];
        # Defaults used by eza
        eza = ["permission" "size" "user" "group" "date" "git" "name"];
        git-left = ["date" "git" "name"];
        git-right = ["name" "git" "date"];

        # Tree between groups of fields
        split = {
          # Permissions to left of file tree
          perm-left = {
            date = ["permission" "user" "group" "name" "date" "git" "size"];
            git = ["permission" "user" "group" "name" "git" "date" "size"];
            size = ["permission" "user" "group" "name" "size" "git" "date"];
          };
          # Permissions to right of file tree
          perm-right = {
            date = ["date" "git" "size" "name" "user" "group" "permission"];
            git = ["git" "date" "size" "name" "user" "group" "permission"];
            size = ["size" "git" "date" "name" "user" "group" "permission"];
          };
        };
        # All fields left of filename
        left = {
          date = ["permission" "user" "group" "size" "git" "date" "name"];
          git = ["permission" "user" "group" "size" "date" "git" "name"];
          size = ["permission" "user" "group" "date" "git" "size" "name"];
        };
        # All fields right of filename
        right = {
          git = ["name" "git" "date" "size" "user" "group" "permission"];
          date = ["name" "date" "git" "size" "user" "group" "permission"];
          size = ["name" "size" "git" "date" "user" "group" "permission"];
        };

        # Dont show permissions, user, group
        noperms = {
          # Tree to left of fields
          left = {
            date = ["name" "date" "git" "size"];
            git = ["name" "git" "date" "size"];
            size = ["name" "size" "git" "date"];
          };

          # Tree to right of fields
          right = {
            size = ["size" "git" "date" "name"];
            date = ["date" "git" "size" "name"];
            ght-git = ["git" "date" "size" "name"];
          };
        };
      in
        git-left;
    };
  };
}
