{ inputs
, config
, lib
, pkgs
, ...
}:
# Note: Must run the following to download unfree blobs for DisplayLink

# https://www.synaptics.com/sites/default/files/exe_files/2023-08/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.8-EXE.zip
# hash = "05m8vm6i9pc9pmvar021lw3ls60inlmq92nling0vj28skm55i92";

# $ nix-prefetch-url --name displaylink-<VersionNoSpecialChars>.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
#   Old: nix-prefetch-url --name displaylink.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
#   Note: NixOS expects filename=displaylink-570.zip, not displaylink.zip
#     nix-prefetch-url --name displaylink-570.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
{
  imports = [ ];

  boot.kernelModules = [ "evdi" ];
  environment.systemPackages = [ pkgs.displaylink ];

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # Connecting a second external monitor
  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  '';
}
