# NOTE: `icon` can use NerdFont icon names: https://www.nerdfonts.com/cheat-sheet
let
  cfgTargetRegex = "^(darwin|h(m|ome|omeManager)|nix(os|vim|-on-droid)?|robotnix|system(-m|M)anager|termux)";
  cfgTypeRegex = "((c|C)onfig(uration)?|(m|M)odule|(l|L)ib|(o|O)verlay|(p|P)ackage|pkg|(p|P)rofile|(s|S)uite)s?(.nix)?$";
in [
  {
    # `*.nix` - All Nix configs
    pattern = "^.*.nix$";
    icon = "nf-linux-nixos";
    importance = 2;
  }
  {
    # `flake.nix` - Nix Flake entrypoint
    pattern = "^flake.nix$";
    icon = "nf-linux-nixos";
    importance = 10;
  }
  {
    # `flake.lock` - Nix Flake lockfile
    # - [x] TODO: flake.lock -> lock | nf- (pinned deps icon, see other lockfiles)
    # Is this relative path to root dir or just filename w/o path?
    pattern = "^flake.lock$";
    icon = "lock";
    importance = -1;
    collapse.name = "flake.nix";
    style = "dimmed";
  }
  {
    # `default.nix` - Top-level import of Nix directory
    pattern = "^default.nix$";
    icon = "nf-linux-nixos";
    importance = 3;
  }
  {
    # `shell.nix` | `devshell.nix` - Nix Development Shells
    pattern = "^(dev)?(s|S)hell(.nix)?$";
    importance = 2;
    icon = "nf-oct-terminal";
    # icon = "nf-dev-terminal";
    # icon = "nf-dev-terminal_badge"
  }
  {
    # `/result` - Nix build output
    pattern = "^result$";
    icon = "nf-md-application_export";
  }
  # --- Nix Framework Files ---
  # - [ ] TODO: (**/)?(secrets|age).nix (agenix config)
  # - [ ] TODO: (**/)?(hive|std).nix (std/hive configs)
  # - [ ] TODO: cells/ ->  (std/hive config dirs)
  # - [ ] TODO: (**/)?((darwin|hm|homeManager|robotnix|nixos|nixvim|wsl|systemManager)((Configuration|Module|Profile|Suite)s?)?)(.nix)?$
  {
    # `darwinConfigurations.nix` - Nix Darwin system entrypoint
    pattern = "^darwin((Configuration|Module|Profile|Suite)s)?(.nix)?$";
    icon = "nf-dev-apple";
  }
  {
    # `homeConfiguration.nix` - home-manager configuration entrypoint
    pattern = "^(hm|home|homeManager)?((Configuration|Module|Profile|Suite)s)?(.nix)?$";
    icon = "nf-md-folder_home";
  }
  {
    # `hm/profiles` - home-manager configuration directory
    pattern = "^(hm|home|homeManager)/?(p|P)rofiles?$";
    icon = "nf-md-folder_home";
  }
  {
    # `hm/` - home-manager configuration directory
    pattern = "^(hm|home|homeManager)/(u|U)sers?$";
    icon = "nf-md-folder_home";
  }
  {
    pattern = "^(hm|home|homeManager)/users?/[a-zA-Z]+(.nix)?$";
    icon = "nf-md-home_account";
  }
  {
    pattern = "^(hm|home|homeManager)/users?/[a-zA-Z]+/secrets?(/|.*)(.nix)?$";
    icon = "nf-md-home_account";
  }
  {
    pattern = "^nix(os|vim)?((Configuration|Module|Profile|Suite)s)?(.nix)?$";
    icon = "nf-linux-nixos";
  }
  # - [ ] TODO: (**/)?(lib|module?|packages|pkg|overlay)s?(.nix)?$
]
