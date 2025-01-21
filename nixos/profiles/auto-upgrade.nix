{ inputs, config, lib, pkgs, ... }@moduleArgs:
let
  emptyRepo = (
    builtins.hasAttr "repo" moduleArgs ||
    !builtins.isAttrs moduleArgs.repo  ||
    moduleArgs.repo == null            ||
    moduleArgs.repo == {}
  );
  repo = if emptyRepo then {
    protocol = "https";
    host = "github.com";
    user = "Lehmanator";
    org = "Lehmanator";
    name = "nix-configs";
    branch = "main"; #"develop";
  } else moduleArgs.repo;

  # Only auto-upgrade if current config came from clean true.
  isClean = inputs.self ? rev;
in
{
  system.autoUpgrade = {
    enable = isClean;
    flake = "git+${repo.protocol}://${repo.host}/${repo.org}/${repo.name}.git?ref=${repo.branch}#${config.networking.hostName}";
    dates = "hourly";
    flags = [ "--refresh" ];
  };

  # Only run if current config (self) is older than the new one.
  systemd.services.nixos-upgrade = lib.mkIf config.system.autoUpgrade.enable {
    serviceConfig.ExecCondition = lib.getExe (
      pkgs.writeShellScriptBin "check-date" ''
        lastModified() {
          nix flake metadata "$1" --refresh --json | ${lib.getExe pkgs.jq} '.lastModified'
        }
        test "$(lastModified "${config.system.autoUpgrade.flake}")"  -gt "$(lastModified "self")"
      ''
    );
  };
}
