{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  xdg.userDirs.XDG_WORK_DIR = lib.mkIf config.xdg.userDirs.enable "${config.xdg.userDirs.XDG_CODE_DIR}/work}";
  services.git-sync.enable = true;
  services.git-sync.repositories = let
    orgName = "PresqueIsleWineDev";
    username = "PresqueIsleWineDev";
    gitHost = "github.com";
  in {
    nix-config = lib.mkIf config.xdg.userDirs.enable {
      uri = "git+ssh://${username}@${gitHost}/${orgName}/nix-configs";
      path = "${config.xdg.userDirs.XDG_WORK_DIR}/nix-configs";
    };
    infra = lib.mkIf config.xdg.userDirs.enable {
      uri = "git+ssh://${username}@${gitHost}/${orgName}/infra-docs";
      path = "${config.xdg.userDirs.XDG_WORK_DIR}/infra";
    };
  };
}
