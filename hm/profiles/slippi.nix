{ inputs, config, lib, pkgs, ... }:
{
  # --- Melee ---------------------------------
  # https://gitlab.com/ramirez7/slippi-netplay-nix
  # https://github.com/UnclePunch/Training-Mode
  # Slippi
  # $ sudo rm -f /etc/udev/rules.d/51-gcadapter.rules && \
  # $ sudo touch /etc/udev/rules.d/51-gcadapter.rules && \
  # $ echo 'SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"' | sudo tee /etc/udev/rules.d/51-gcadapter.rules > /dev/null && \
  # $ sudo udevadm control --reload-rules
  # TODO: Set `~/.config/SlippiOnline/Slippi/user.json`
  # TODO: Set `~/.config/SlippiOnline/GameSettings/GALE01.ini`
  # TODO: Set `~/.config/SlippiOnline/GameSettings/GALJ01.ini`
  # TODO: Set `~/.config/SlippiOnline/Config/Dolphin.ini`
  # TODO: Set `~/.config/SlippiPlayback/Config/Dolphin.ini`
  # TODO: Set `~/.config/slippi-dolphin/netplay-beta/Config/Dolphin.ini`
  # TODO: Set `~/.config/slippi-dolphin/netplay/Config/Dolphin.ini`
  # TODO: Symlink all `.../Dolphin.ini` files.
  imports = [inputs.slippi.homeManagerModules.default];
  
  slippi-launcher = let
    gamesPath = lib.attrByPath ["xdg" "userDirs" "extraConfig" "XDG_GAMES_HOME"] "${config.home.homeDirectory}/Games" config;
  in {
    enable = true;
    enableJukebox = false;
    launchMeleeOnPlay = true;
    isoPath = "${gamesPath}/Super-Smash-Bros-Melee.nkit.iso";

    # --- Replays ---
    rootSlpPath = "${gamesPath}/Replays/Slippi";
    extraSlpPaths = [];
    useMonthlySubfolders = false;

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
