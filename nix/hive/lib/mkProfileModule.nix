{
  inputs,
  cell,
}:
# Map <profileType>Profiles.<name> -> <profileType>Modules.profile-<name>
#
# Notes:
# - Assumes profiles don't set `config` or `options` attrs.
#
# To-Dos:
# - [ ] Allow passing either by name or value, so we can use profiles outside cell.
#   - [ ] Determine if these should be separate libs
# - [ ] Make module to define options.profiles
# - [ ] Make lib to handle list of modules
# - [ ] Make lib to perform similar for suites.
let
  l = inputs.nixpkgs.lib // builtins;
in
  profile: {
    # Type of profile: e.g. darwinProfiles, diskoProfiles, hardwareProfiles, homeProfiles, nixosProfiles
    profileType ? "nixos",
    # Extra options to provide
    options ? {},
    # Pass metadata for Standard
    meta ? {},
    ...
  } @ args: let
    config = l.removeAttrs profile ["imports"];
  in
    l.mapAttrs' (
      n: v:
        l.nameValuePair ("profile-" + n) {
          config,
          lib,
          pkgs,
          ...
        } @ moduleArgs: let
          cfg = config.profiles.${n};
        in {
          options.profiles.${n} = options // {enable = l.mkEnableOption "${profileType}Profile.${n}";};
          imports = l.mkIf cfg.enable (v.imports or []) ++ [cell."${profileType}Profiles".${n}];
          config = l.mkIf cfg.enable l.removeAttrs v ["imports"];
        }
    )
