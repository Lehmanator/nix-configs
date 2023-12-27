{ inputs
, config
, lib
, pkgs
, repo ? {
    protocol = "https";
    host = "github.com";
    user = "Lehmanator";
    org = "Lehmanator";
    name = "nix-configs";
    branch = "main"; #"develop";
  }
, ...
}:
{
  system.autoUpgrade =
    let
      # Only auto-upgrade if current config came from clean true.
      isClean = inputs.self ? rev;
    in
    {
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
