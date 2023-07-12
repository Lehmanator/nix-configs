{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

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
