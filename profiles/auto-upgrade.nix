{ inputs
, config, lib, pkgs
, repo ? {
  protocol = "https";
  host     = "github.com";
  user     = "PresqueIsleWineDev";
  org      = "PresqueIsleWineDev";
  name     = "nix-configs";
  branch   = "main";
}
, ...
}:
{
  imports = [
  ];
  system.autoUpgrade = {
    enable = true;
    flake = "git+${repo.protocol}://${repo.host}/${repo.org}/${repo.name}.git?ref=${repo.branch}#${config.networking.hostName}";
    dates = "15:30";
  };
}
