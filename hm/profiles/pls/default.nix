{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.pls = {
    enable = true;
    enableAliases = false;
    package = pkgs.pls;
  };

  # No NixOS/home-manager options to configure pls settings exist yet.
  # For now, we write this config manually.
  xdg.configFile.pls = {
    target = "pls.yaml";
    onChange = ''
      echo "home-manager changed config for: pls"
    '';
    text = lib.generators.toYAML {} {
      app_const = {
        # imp_styles = [[5 "bright_magenta"]];
        table = {
          # Makes header underline skip gaps between columns
          header_style = "clear";
          column_names = {
            dev = "<underline>Device</>";
            ino = "<underline>inode</>";
            nlink = "<underline>Links</>";
            perm = "<underline>Permissions</>";
            oct = "<underline>Octal</>";
            user = "<underline>User</>";
            uid = "<underline>UID</>";
            group = "<underline>Group</>";
            gid = "<underline>GID</>";
            size = "<underline>Size</>";
            blocks = "<underline>Blocks</>";
            btime = "<underline>Created</>";
            ctime = "<underline>Changed</>";
            mtime = "<underline>Modified</>";
            atime = "<underline>Accessed</>";
            git = "<underline>Git</>";
            name = "<underline>Name</>";
          };
        };
      };
      # https://pls.cli.rs/guides/markup/
      # Named Colors: black, red, green, yellow, blue, magenta, cyan, white + "bright_<color>"
      # RGB Colors: <rgb(0,255,0)>green</>
      # Background: <bg:COLOR>text</>
      entry_const = {
        group_styles = {
          curr = "bold green";
          other = "";
        };
        # oct_styles = {};
        perm_styles = {
          none = "dimmed";
          read = "cyan";
          write = "red";
          execute = "orange";
          special = "magenta";
        };
        size_styles = {
          mag = "bold";
          # prefix = "";
          # base = "";
        };
        # timestamp_formats = {
        #   btime = "<blue>[day] [month repr:short] [hour repr:24]:[minute]</>"; # Creation at
        #   ctime = ""; # Changed at
        #   mtime = ""; # Modified at
        #   atime = ""; # Accessed at
        # };
        user_styles = {
          curr = "bold green";
          other = "";
        };
      };
      specs = [] ++ (import ./nix.nix);
    };
  };

  # By default, pls reads from `~/.pls.yaml`.
  # I prefer to follow the XDG Base Directories spec by using `~/.config/pls.yaml`.
  home.sessionVariables.PLS_CONFIG = "~/${config.xdg.configFile.pls.target}";

  # TODO: Concat defaults lists for args
  home.shellAliases = rec {
    l = (lib.getExe pkgs.pls) + " --grid=true --down=true --header=false";
    # ll = lib.mkDefault "${l} -d none -d oct -d user -d size -d mtime -d git --header=false";
    # lt = "${l} --tree";

    p = l;
    pl = "${l} -d none -d oct -d user -d size -d mtime -d git --header=false";
    pls-size = "${pl} --det=none --det=size --sort=cat_ --sort=size"; # Sort by size
    pls-modified = "${pl} --det=none --det=mtime --sort=cat_ --sort=mtime_"; # Sort by date modified
    pls-created = "${pl} --det=none --sort=cat_ --det=btime --sort=btime_"; # Sort by date created
    biggest = pls-size;
    largest = pls-size;
    latest = pls-modified;
    newest = pls-created;
  };
}
