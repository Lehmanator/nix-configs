{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  # Note: Must run the following to download unfree blobs for DisplayLink
  # https://www.synaptics.com/sites/default/files/exe_files/2023-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.8-EXE.zip
  # hash = "05m8vm6i9pc9pmvar021lw3ls60inlmq92nling0vj28skm55i92";
  # $ nix-prefetch-url --name displaylink-<VersionNoSpecialChars>.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
  #   Old: nix-prefetch-url --name displaylink.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
  #   Note: NixOS expects filename=displaylink-570.zip, not displaylink.zip
  #     nix-prefetch-url --name displaylink-570.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
  displaylink_version = "5.7";
  displaylink_date = "2023-04";

  displaylink_link = "https://www/synaptics.com/sites/default/files/exe_files/${displaylink_date}/Displaylink%20USB%20Graphics%20Software%20for%20Ubuntu${displaylink_version}-EXE.zip";
  displaylink_filename = "displaylink.zip";
in {
  # Add kernel module to list of those available to load via modprobe
  boot.extraModulePackages = ["evdi"];

  # Load kernel module by default
  boot.kernelModules = ["evdi"];

  # Add Displaylink package
  environment.systemPackages = [pkgs.displaylink];

  # Use displaylink video drivers
  services.xserver.videoDrivers = ["displaylink" "modesetting"];

  # Connecting a second external monitor
  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  '';

  # Shell command to download binary package (necessary before install
  # TODO: Make automatic
  environment.shellAliases = {
    displaylink-download = "nix-prefetch-url --name ${displaylink_filename} ${displaylink_link}";
  };
}
