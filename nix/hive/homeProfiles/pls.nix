{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
# --- pls ---
# https://pls.cli.rs/reference/conf/
# No NixOS/home-manager options exist yet. For now, use one of:
# - home.shellAliases
# - pkgs.toTOML <configAttrs>
let
  defaultsAll = ["--icon=true" "--collapse=true"];
  defaultsViewGrid = ["--grid=true" "--down=true"];
  defaultsViewDetail = [
    "--det=none"
    "--det=oct"
    "--det=user"
    "--det=size"
    "--det=mtime"
    "--det=git"
    "--header=false"
    "--sym=true"
  ];
  defaultsSort = {
    largest = [
      "--det=none" # Remove all detail fields
      "--det=size" # Detail field: size
      "--sort=cat_" # Sort dirs first
      "--sort=size" # Sort by descending file size"
    ];
  };
in {
  # pls needs this env var, otherwise it reads from ~/.pls.yaml
  home.sessionVariables.PLS_CONFIG =
    config.xdg.configHome
    + config.xdg.configFile."pls.yaml".target;

  # TODO: Concat defaults lists for args
  home.shellAliases = rec {
    #lib.mkIf program.pls.enable && !(config.program.eza.enableAliases || config.program.lsd.enableAliases) {
    l = "${pkgs.pls}/bin/pls --grid=true --down=true --header=false";
    #ll =
    #  lib.mkDefault
    #  "${l} -d none -d oct -d user -d size -d mtime -d git --header=false";
    #lt = "${l} --tree";

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

  programs.pls = let
    program = "pls";
  in {
    enable = true;
    enableAliases = lib.mkDefault program == "pls";
  };

  xdg.configFile."pls.yaml" = {
    enable = true;
    onChange = ''
      echo "home-manager changed config for: pls"
    '';
    target = "pls.yaml";
    text = lib.generators.toYAML {} {
      app_const = {
        #imp_styles = [[5 "bright_magenta"]];
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
        #oct_styles = {};
        perm_styles = {
          none = "dimmed";
          read = "cyan";
          write = "red";
          execute = "orange";
          special = "magenta";
        };
        size_styles = {
          mag = "bold";
          #prefix = "";
          #base = "";
        };
        #timestamp_formats = {
        #  btime = "<blue>[day] [month repr:short] [hour repr:24]:[minute]</>"; # Creation at
        #  ctime = ""; # Changed at
        #  mtime = ""; # Modified at
        #  atime = ""; # Accessed at
        #};
        user_styles = {
          curr = "bold green";
          other = "";
        };
      };
      # TODO: Make .pls.yaml for repo. Use https://www.nerdfonts.com/cheat-sheet to replace icons
      # TODO: Move categories to appropriate profiles. (e.g. git stuff goes in profiles.hm.git)
      # TODO: Figure out regex syntax used here.
      # TODO: Figure out if dirs are relative to /, /home/<user>, or current directory.
      # TODO: Create reusable regex variables.
      #specs = let
      #  cfgTargetRegex = "^(darwin|h(m|ome|omeManager)|nix(os|vim|-on-droid)?|robotnix|system(-m|M)anager|termux)";
      #  cfgTypeRegex = "((c|C)onfig(uration)?|(m|M)odule|(l|L)ib|(o|O)verlay|(p|P)ackage|pkg|(p|P)rofile|(s|S)uite)s?(.nix)?$";
      #in [
      #  # --- Nix-specific Files ---
      #  {
      #    pattern = "^.*.nix$";
      #    icon = "nf-linux-nixos"; # Can use NerdFont icon names: https://www.nerdfonts.com/cheat-sheet
      #    importance = 2;
      #  }
      #  # - [x] TODO: flake.nix -> nf-linux-nixos
      #  {
      #    pattern = "^flake.nix$";
      #    importance = 10;
      #  }
      #  {
      #    # Is this relative path to root dir or just filename w/o path?
      #    pattern = "^flake.lock$";
      #    icon = "lock";
      #    importance = -1;
      #    collapse.name = "flake.nix";
      #    style = "dimmed";
      #  }
      #  # - [x] TODO: flake.lock -> lock | nf- (pinned deps icon, see other lockfiles)
      #  # - [ ] TODO: default.nix ->
      #  {
      #    pattern = "^default.nix$";
      #    importance = 3;
      #  }
      #  {
      #    pattern = "^(dev)?(s|S)hell(.nix)?$";
      #    importance = 2;
      #    icon = "nf-oct-terminal";
      #  } # nf-dev-terminal | nf-dev-terminal_badge
      #  {
      #    pattern = "^result$";
      #    icon = "nf-md-application_export";
      #  } # Nix build output
      #
      #  # --- Nix Framework Files ---
      #  # - [ ] TODO: (**/)?(secrets|age).nix (agenix config)
      #  # - [ ] TODO: (**/)?(hive|std).nix (std/hive configs)
      #  # - [ ] TODO: cells/ ->  (std/hive config dirs)
      #  # - [ ] TODO: (**/)?((darwin|hm|homeManager|robotnix|nixos|nixvim|wsl|systemManager)((Configuration|Module|Profile|Suite)s?)?)(.nix)?$
      #  {
      #    pattern = "^darwin((Configuration|Module|Profile|Suite)s)?(.nix)?$";
      #    icon = "nf-dev-apple";
      #  }
      #  {
      #    pattern = "^(hm|home|homeManager)?((Configuration|Module|Profile|Suite)s)?(.nix)?$";
      #    icon = "nf-md-folder_home";
      #  }
      #  {
      #    pattern = "^(hm|home|homeManager)/?(p|P)rofiles?$";
      #    icon = "nf-md-folder_home";
      #  }
      #  {
      #    pattern = "^(hm|home|homeManager)/(u|U)sers?$";
      #    icon = "nf-md-folder_home";
      #  }
      #  {
      #    pattern = "^(hm|home|homeManager)/users?/[a-zA-Z]+(.nix)?$";
      #    icon = "nf-md-home_account";
      #  }
      #  {
      #    pattern = "^(hm|home|homeManager)/users?/[a-zA-Z]+/secrets?(/|.*)(.nix)?$";
      #    icon = "nf-md-home_account";
      #  }
      #  {
      #    pattern = "^nix(os|vim)?((Configuration|Module|Profile|Suite)s)?(.nix)?$";
      #    icon = "nf-linux-nixos";
      #  }
      #
      #  # - [ ] TODO: (**/)?(lib|module?|packages|pkg|overlay)s?(.nix)?$
      #  # - [ ] TODO: ./build
      #  # - [ ] TODO: ./out(put)?
      #
      #  # Program-related Nix Configs:
      #  # - [ ] TODO: (**/)?(nix(os)?) -> nf-linux-nixos
      #  # - [ ] TODO: (**/)?(darwin) -> nf-
      #  # - [ ] TODO: (**/)?n(eo)?vim(.nix)? -> nf-linux-neovim
      #  {
      #    pattern = "^.*.vim$";
      #    icon = "nf-dev-vim";
      #  }
      #  # - [ ] TODO: (**/)?vscod(e|ium)(.nix)? -> nf-linux-neovim
      #
      #  # Common Directories:
      #  # - [ ] TODO: (**/)?docs ->
      #  # - [ ] TODO: (**/)?src ->
      #  # Repo Dotfiles:
      #  # - TODO: .* -> color=dimmed,
      #  # - TODO: .direnv (
      #  # - TODO: .envrc
      #
      #  # Git
      #  # - TODO: .git -> nf-md-git | nf-dev-git_branch | nf-oct-git_branch | nf-fa-git
      #  # - TODO: .gitignore -> nf-seti-ignored | nf-cod-sync_ignored (collapse under .git/)
      #  # - TODO: .github -> nf-{cod,fa,md,seti}-github | nf-dev-github_{full,alt} | nf-{dev,fa}-github_alt | nf-oct-logo_github (collapse under .git/)
      #  # - TODO: .github/workflows/*.ya?ml -> nf-cod-github_action
      #  # - TODO: .pre-commit-config.yaml
      #  #
      #  # --- Secrets ---
      #  # - TODO: .sops.yaml ->
      #  # - TODO: *.age ->
      #  # - TODO: *.sops.yaml ->
      #  # - TODO: **/.?(secrets|keys)/*.sops.yaml ->
      #  # - TODO: ^id_*$ -> <bg:red><white></></> (Highlight warning color for all secret types)
      #  {
      #    pattern = "^.ssh$";
      #    icon = "nf-md-ssh";
      #    importance = 1;
      #  }
      #  {
      #    # --- Encrypted Secrets ---
      #    pattern = "^.*.(age|enc|crypt|encrypted)$";
      #    icon = "nf-fa-user_secret";
      #    importance = 1;
      #  }
      #  {
      #    pattern = "^.?.(key|secret|decrypted|luks|p11|pkcs|token|cred(ential))s?.*$";
      #    icon = "nf-md-file_key";
      #    importance = 15;
      #    style = "<bg:red><white></></>";
      #  }
      #  {
      #    pattern = "^.g(nu)?pg$";
      #    icon = "nf-md-folder_key";
      #    importance = 1;
      #  } # nf-md-key_chain | nf-oct-key
      #
      #  # --- Linux Dirs ---
      #  # Parent home directory
      #  {
      #    pattern = "^(~|/home|home)$";
      #    icon = "nf-md-folder_home";
      #  }
      #  # User Home directories
      #  {
      #    pattern = "^(~|/home|home)/[a-zA-Z]*$";
      #    icon = "nf-md-home_account";
      #  }
      #
      #  # --- XDG Dirs ---
      #  # TODO: XDG_STATE_HOME
      #  {
      #    pattern = "^.config/?$";
      #    icon = "nf-custom-folder_config"; # icon="nf-md-application_cog";}
      #    importance = 3;
      #  }
      #  {
      #    pattern = "^.(local/share|data)/?$";
      #    icon = "nf-md-database_import_outline";
      #  }
      #  {
      #    pattern = "^.cache/?$";
      #    icon = "nf-oct-cache";
      #  }
      #  {
      #    pattern = "^.local/state$";
      #    icon = "nf-md-application_edit";
      #  }
      #  # --- XDG User Dirs ---
      #  {
      #    pattern = "^Applications$";
      #    icon = "nf-md-application";
      #  }
      #  {
      #    pattern = "^Code$";
      #    icon = "nf-md-application_brackets";
      #  }
      #  # --- Flatpaks, repos, & their data dirs ---
      #  {
      #    pattern = "^(.var/?|.*.flatpak(ref|repo)?)$";
      #    icon = "nf-linux-flathub";
      #  }
      #
      #  # --- Misc ---
      #  # - [ ] TODO: ^(**/*)?.old(.*)?$ -> dimmed (old files)
      #  # - [ ] TODO: ^(**/*)?.(bak|backup)(.*)?$ -> dimmed (backup files)
      #  {
      #    pattern = "^.(android|fastboot)$";
      #    icon = "nf-dev-android"; # nf-md-android | nf-md-tablet_android
      #    importance = -1;
      #  }
      #];
    };
  };
}
