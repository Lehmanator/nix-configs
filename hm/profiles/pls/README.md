# pls

Extremely configurable alternative to ls.

<https://pls.cli.rs/reference/conf/>

## Specs

Specs define how to treat files matching certain patterns.

### To-Do

- [ ] TODO: Make .pls.yaml for repo. Use https://www.nerdfonts.com/cheat-sheet to replace icons
- [ ] TODO: Move categories to appropriate profiles. (e.g. git stuff goes in profiles.hm.git)
- [ ] TODO: Figure out regex syntax used here.
- [ ] TODO: Figure out if dirs are relative to /, /home/<user>, or current directory.
- [ ] TODO: Create reusable regex variables.

This snippet was removed from [./default.nix](./default.nix) to prevent cluttering the config file.

```nix
  # - [ ] TODO: ./build
  # - [ ] TODO: ./out(put)?

  # Program-related Nix Configs:
  # - [ ] TODO: (**/)?(nix(os)?) -> nf-linux-nixos
  # - [ ] TODO: (**/)?(darwin) -> nf-
  # - [ ] TODO: (**/)?n(eo)?vim(.nix)? -> nf-linux-neovim
  {
    pattern = "^.*.vim$";
    icon = "nf-dev-vim";
  }

  # - [ ] TODO: (**/)?vscod(e|ium)(.nix)? -> nf-linux-neovim

  # Common Directories:
  # - [ ] TODO: (**/)?docs ->
  # - [ ] TODO: (**/)?src ->

  # Repo Dotfiles:
  # - TODO: .* -> color=dimmed,
  # - TODO: .direnv (
  # - TODO: .envrc

  # Git
  # - TODO: .git -> nf-md-git | nf-dev-git_branch | nf-oct-git_branch | nf-fa-git
  # - TODO: .gitignore -> nf-seti-ignored | nf-cod-sync_ignored (collapse under .git/)
  # - TODO: .github -> nf-{cod,fa,md,seti}-github | nf-dev-github_{full,alt} | nf-{dev,fa}-github_alt | nf-oct-logo_github (collapse under .git/)
  # - TODO: .github/workflows/*.ya?ml -> nf-cod-github_action
  # - TODO: .pre-commit-config.yaml

  # --- Secrets ---
  # - TODO: .sops.yaml ->
  # - TODO: *.age ->
  # - TODO: *.sops.yaml ->
  # - TODO: **/.?(secrets|keys)/*.sops.yaml ->
  # - TODO: ^id_*$ -> <bg:red><white></></> (Highlight warning color for all secret types)
  {
    pattern = "^.ssh$";
    icon = "nf-md-ssh";
    importance = 1;
  }

  # --- Encrypted Secrets ---
  {
    pattern = "^.*.(age|enc|crypt|encrypted)$";
    icon = "nf-fa-user_secret";
    importance = 1;
  }

  {
    pattern = "^.?.(key|secret|decrypted|luks|p11|pkcs|token|cred(ential))s?.*$";
    icon = "nf-md-file_key";
    importance = 15;
    style = "<bg:red><white></></>";
  }

  {
    pattern = "^.g(nu)?pg$";
    icon = "nf-md-folder_key";
    importance = 1;
  } # nf-md-key_chain | nf-oct-key

  # --- Linux Dirs ---
  # Parent home directory
  {
    pattern = "^(~|/home|home)$";
    icon = "nf-md-folder_home";
  }

  # User Home directories
  {
    pattern = "^(~|/home|home)/[a-zA-Z]*$";
    icon = "nf-md-home_account";
  }

  # --- XDG Dirs ---
  # TODO: XDG_STATE_HOME
  {
    pattern = "^.config/?$";
    icon = "nf-custom-folder_config"; # icon="nf-md-application_cog";}
    importance = 3;
  }

  {
    pattern = "^.(local/share|data)/?$";
    icon = "nf-md-database_import_outline";
  }

  {
    pattern = "^.cache/?$";
    icon = "nf-oct-cache";
  }

  {
    pattern = "^.local/state$";
    icon = "nf-md-application_edit";
  }

  # --- XDG User Dirs ---
  {
    pattern = "^Applications$";
    icon = "nf-md-application";
  }

  {
    pattern = "^Code$";
    icon = "nf-md-application_brackets";
  }

  # --- Flatpaks, repos, & their data dirs ---
  {
    pattern = "^(.var/?|.*.flatpak(ref|repo)?)$";
    icon = "nf-linux-flathub";
  }

  # --- Misc ---
  # - [ ] TODO: ^(**/*)?.old(.*)?$ -> dimmed (old files)
  # - [ ] TODO: ^(**/*)?.(bak|backup)(.*)?$ -> dimmed (backup files)
  {
    pattern = "^.(android|fastboot)$";
    icon = "nf-dev-android"; # nf-md-android | nf-md-tablet_android
    importance = -1;
  }
```

## Command

### To-Do

Removed these lists of args from [./default.nix](./default.nix) to declutter the actual config files.

```nix
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
in
```

## Comparison of `ls` Alternatives

### Args

- [ ] TODO: Make table

Originally found in [`hm/profiles/eza.nix`](../eza.nix).

```
readable = { size = true; date = true; perms = true; };

 --- Sort Fields ---
 eza: accessed, changed, created, e|Extension, inode, modified, n|Name, size, type, none (Caps sort upper before lower)
 lsd:                               extension,            time,   name, size, version
 pls:

 --- Time Fields ---
 eza: modified, changed, accessed, and created
 lsd:
 pls:

 --- Time Styles ---
 eza: default, iso, long-iso, full-iso
 lsd:
 pls:

 --- Toggle Opts ---
 exa:  always, never, automatic
 lsd:  always, never, auto
 pls:

 --- Blocks ---
 exa: permissions, size, user, date, name
 lsd: permissions, user, group, size, date, name
 pls:

````
