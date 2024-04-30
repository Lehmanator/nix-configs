{ inputs
, osConfig
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    inputs.ssbm-nix.homeManagerModule
    #../emu
  ];

  # TODO: Only enable if overlay not provided via OS nixpkgs.
  #nixpkgs.overlays = lib.mkIf (!osConfig.ssbm.overlay.enable) [ inputs.ssbm-nix.overlay ];
  #nixpkgs.overlays = [ inputs.ssbm-nix.overlay ];

  # --- Melee ---------------------------------
  # https://gitlab.com/ramirez7/slippi-netplay-nix
  # https://github.com/UnclePunch/Training-Mode
  # Slippi
  # $ sudo rm -f /etc/udev/rules.d/51-gcadapter.rules && \
  # $ sudo touch /etc/udev/rules.d/51-gcadapter.rules && \
  # $ echo 'SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"' | sudo tee /etc/udev/rules.d/51-gcadapter.rules > /dev/null && \
  # $ sudo udevadm control --reload-rules

  ssbm = {
    slippi-launcher = with config.xdg.userDirs.extraConfig; {
      enable = true;
      launchMeleeOnPlay = true;
      enableJukebox = true;
      useMonthlySubfolders = false;

      isoPath = "${XDG_GAMES_DIR}/Super-Smash-Bros-Melee_USA_v1.02.iso";
      rootSlpPath = "${XDG_GAMES_DIR}/Replays/Slippi";
      spectateSlpPath = "${XDG_GAMES_DIR}/Replays/Slippi/Spectate";
      #rootSlpPath = "${config.xdg.dataHome}/Slippi";
      #spectateSlpPath = "${config.xdg.dataHome}/Slippi/Spectate";
      #netplayDolphinPath = "${pkgs.slippi-netplay}";
      #playbackDolphinPath = "${pkgs.slippi-playback}";
    };
  };

  # TODO: Set `~/.config/SlippiOnline/Slippi/user.json`
  # TODO: Set `~/.config/SlippiOnline/GameSettings/GALE01.ini`
  # TODO: Set `~/.config/SlippiOnline/GameSettings/GALJ01.ini`
  # TODO: Set `~/.config/SlippiOnline/Config/Dolphin.ini`
  # TODO: Set `~/.config/SlippiPlayback/Config/Dolphin.ini`
  # TODO: Set `~/.config/slippi-dolphin/netplay-beta/Config/Dolphin.ini`
  # TODO: Set `~/.config/slippi-dolphin/netplay/Config/Dolphin.ini`
  # TODO: Symlink all `.../Dolphin.ini` files.

  home.packages = [
    pkgs.libGLU
    pkgs.libopenglrecorder
    pkgs.fuse
    pkgs.fuse3
    pkgs.fuse-common
    pkgs.qgnomeplatform-qt6
    pkgs.qt6.full
    pkgs.qt6Packages.qt6gtk2

    pkgs.appimagekit
    pkgs.appimage-run

    pkgs.dolphin-emu
  ];
}
