{ inputs, config, lib, pkgs, ... }:
let
  # Note: Must run the following to download unfree blobs for DisplayLink
  # https://www.synaptics.com/sites/default/files/exe_files/2023-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.8-EXE.zip
  # hash = "05m8vm6i9pc9pmvar021lw3ls60inlmq92nling0vj28skm55i92";
  # $ nix-prefetch-url --name displaylink-<VersionNoSpecialChars>.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
  #   Old: nix-prefetch-url --name displaylink.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
  #   Note: NixOS expects filename=displaylink-570.zip, not displaylink.zip
  #     nix-prefetch-url --name displaylink-570.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
  #     nix-prefetch-url --name displaylink-600.zip https://www.synaptics.com/sites/default/files/exe_files/2024-05/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu6.0-EXE.zip
  # 1ixrklwk67w25cy77n7l0pq6j9i4bp4lkdr30kp1jsmyz8daaypw
  displaylink_version = "6.0";
  displaylink_date = "2024-05";

  displaylink_link = "https://www/synaptics.com/sites/default/files/exe_files/${displaylink_date}/Displaylink%20USB%20Graphics%20Software%20for%20Ubuntu${displaylink_version}-EXE.zip";
  displaylink_filename = "displaylink.zip";
in {
  boot.extraModulePackages = [pkgs.linuxPackages.evdi];          # Module in list of available to modprobe load
  boot.kernelModules       = ["evdi"];                           # Load by default
  services.xserver.videoDrivers = ["displaylink" "modesetting"]; # Use displaylink video drivers

  # Connecting a second external monitor
  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  '';

  # Shell command to download binary package (necessary before install
  # TODO: Make automatic
  environment.shellAliases = {
    displaylink-download = "nix-prefetch-url --name ${displaylink_filename} ${displaylink_link}";
  };
  environment.systemPackages = [pkgs.displaylink];  # Add Displaylink package
}
