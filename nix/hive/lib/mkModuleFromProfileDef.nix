{ inputs, cell }:
#
let
  l = inputs.nixpkgs.lib // builtins;
in
{ meta ? { }
, extraOptions ? { }
, profileType ? "nixos"
, profileName
, profileDefinition ? { }
  ...
}@libargs:
#
let
  profileBody = profileDefinition _module.args;
in

{ config, lib, pkgs, ... }@profileArgs:

let
  profileBody = (profileDefinition profileArgs);
  cfg = config.profiles.${profileName};
in
{
  options = extraOptions // {
    enable = l.mkEnableOption "${profileType}Profiles.${profileName}";
    name = l.mkOption {
      type = l.types.str;
      description = "Name of the ${profileType} profile.";
      example = "systemd-boot";
    };
  };

}
