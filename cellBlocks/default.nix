# Import each file nested inside this dir, excluding self.
#   then merge their lists.
{ blockTypes, lib, }:
let
  inherit (lib.fileset) difference fileFilter gitTracked intersection toList;
  incl = {
    non-default = file: file.name != "default.nix";
    nix-only = file: file.hasExt "nix";
    files-only = file: file.type == "regular";
    #vcs-only = intersection ./. (gitTracked ../.);
  };
  filters = file:
    file.type == "regular" && file.hasExt "nix" && file.name != "default.nix";
  dirfs = intersection ./. gitTracked ../.;

  cfgTypes = [
    #"colmena" "darwin" "disko" "home" "nixos"
    "flake"
    "hardware"
    "liminix"
    "nixvim"
    "robotnix"
    "shell"
    "systemManager"
    "termux"
    "wsl"
  ];

  mkParts = sys:
    lib.fold (a: b: a ++ b) [ ] (lib.map (component:
      (blockTypes.functions "${sys}${component}") [
        "Configurations"
        "Modules"
        "Profiles"
        "Suites"
      ]));
  baseBTs = with blockTypes; [
    (functions "lib")
    (functions "overlays")
    (files "templates")
    (installables "packages" { ci.build = true; })

    # +------------------------+
    # | std.blockTypes         |
    # +------------------------+
    (arion "arion")
    (files "files")
    (kubectl "kubectl")
    (microvms "microvms")
    (namaka "namaka")
    (nixostests "nixosTests")
    (nomad "nomad")
    (nvfetcher "nvfetcher")
    (pkgs "pkgs")
    (terra "tf" "git@github.com:Lehmanator/nix-configs.git")

    (containers "containers")
    (data "data")
    (devshells "shells")

    # TODO: Split by shell type?
    (runnables "scripts")
    (runnables "tasks")

    # +------------------------+
    # | hive.blockTypes        |
    # +------------------------+
    colmenaConfigurations
    darwinConfigurations
    diskoConfigurations
    homeConfigurations
    nixosConfigurations

    # +------------------------+
    # | omnibus.flake. blockTypes      |
    # +------------------------+
    #(jupyenv "jupyenv")
  ];
  # TODO: Build equivalence ruleset to filter out duplicates
in
baseBTs ++ (
  # +------------------------+
  # | custom blockTypes      |
  # +------------------------+
  lib.fold (a: b: a ++ b) [ ]
    (builtins.map (f: import f { inherit blockTypes; }) (lib.unique
      (toList (intersection (gitTracked ../.) (fileFilter filters ./.)))))
)
