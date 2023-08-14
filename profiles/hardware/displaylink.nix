{ inputs, self
, config, lib, pkgs
, ...
}:
# Note: Must run the following to download unfree blobs for DisplayLink
#  nix-prefetch-url --name displaylink.zip https://www.synaptics.com/sites/default/files/exe_files/2023-04/DisplayLink%20USB%20Graphics%20Software%20for%20Ubuntu5.7-EXE.zip
{
  imports = [
  ];

  services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

  # Connecting a second external monitor
  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  '';
}
