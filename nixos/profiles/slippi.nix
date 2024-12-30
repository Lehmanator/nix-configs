{ inputs, config, lib, pkgs, ... }:
{
  imports = [inputs.slippi.nixosModules.default];
  gamecube-controller-adapter = {
    enable = true;
    overclocking-kernel-module = true;
    udev-rules.enable = true;
    # udev-rules.rules = ''
    #   ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="666", SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device" TAG+="uaccess"
    # '';
  };

  home-manager.sharedModules = [
    inputs.slippi.homeManagerModules.default
    { slippi-launcher = {
      enable = true;
      enableJukebox = false;
      launchMeleeOnPlay = true;
      isoPath = "~/Games/Super-Smash-Bros-Melee.nkit.iso";

      # --- Replays ---
      rootSlpPath = "~/Games/Replays/Slippi";
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
    }; }
  ];

}
