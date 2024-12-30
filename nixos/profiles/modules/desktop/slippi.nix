{ inputs, config, lib, pkgs, ... }: {

  imports = [inputs.slippi.nixosModules.default];

  gamecube-controller-adapter = {
    enable                     = lib.mkDefault true;
    overclocking-kernel-module = lib.mkDefault true;
    udev-rules.enable          = lib.mkDefault true;
    # udev-rules.rules = lib.mkDefault ''
    #   ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="666", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device" TAG+="uaccess"
    # '';
  };

  home-manager.sharedModules = [
    inputs.slippi.homeManagerModules.default
    ({ config, lib, ... }: let
      gamesPath = lib.attrByPath ["xdg" "userDirs" "extraConfig" "XDG_GAMES_HOME"] "${config.home.homeDirectory}/Games" config;
    in {
      slippi-launcher = rec {
        enable               = lib.mkDefault true;
        enableJukebox        = lib.mkDefault false;
        launchMeleeOnPlay    = lib.mkDefault true;
        isoPath              = lib.mkDefault "${gamesPath}/Super-Smash-Bros-Melee.nkit.iso"; # "melee.iso";

        # --- Replays ---
        rootSlpPath          = lib.mkDefault "${gamesPath}/Slippi";
        specateSlpPath       = lib.mkDefault rootSlpPath + "/Spectate";
        extraSlpPaths        = lib.mkDefault [];
        useMonthlySubfolders = lib.mkDefault false;

        # --- Versions ---
        useNetplayBeta = true;
        # netplayVersion = "";
        # netplayHash = "";
        # netplayBetaVersion = "";
        # netplayBetaHash = "";
        # playbackVersion = "";
        # playbackHash = "";
        # launcherVersion = "";
        # launcherHash = "";
      };
    })
    # --- OR ---
    #../../../hm/profiles/modules/ssbm-nix.nix
  ];
}
