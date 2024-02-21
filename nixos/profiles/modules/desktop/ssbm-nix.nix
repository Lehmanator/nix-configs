{ inputs
, config
, lib
, pkgs
, user
, ...
}: {
  imports = [ inputs.ssbm-nix.nixosModule ];

  ssbm = {
    overlay.enable = lib.mkDefault true;
    cache.enable = lib.mkDefault true;
    gcc = {
      oc-kmod.enable = lib.mkDefault false;
      rules.enable = lib.mkDefault true;
    };
    keyb0xx.enable = lib.mkDefault false;
  };

  home-manager.sharedModules = [
    inputs.ssbm-nix.homeManagerModule
    ({ config
     , lib
     , pkgs
     , user
     , ...
     }: {
      ssbm = {
        slippi-launcher =
          let
            isoName = "melee.iso";
            gamesPath =
              if config.xdg.userDirs.extraConfig ? "XDG_GAMES_HOME"
              then config.xdg.userDirs.extraConfig.XDG_GAMES_HOME
              else config.home.homeDirectory + "/Games";
            isoFile = gamesPath + "/" + isoName;
          in
          rec {
            enable = lib.mkDefault true;
            isoPath = lib.mkDefault isoFile;
            launchMeleeOnPlay = lib.mkDefault true;
            enableJukebox = lib.mkDefault true;
            rootSlpPath = lib.mkDefault "${gamesPath}/Slippi";
            useMonthlySubfolders = lib.mkDefault false;
            specateSlpPath = lib.mkDefault rootSlpPath + "/Spectate";
          };
      };
    })
    # --- OR ---
    #../../../hm/profiles/modules/ssbm-nix.nix
  ];
}
