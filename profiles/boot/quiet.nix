{ inputs
, config, lib, pkgs
, ...
}:
{

  imports = [
  ];

  # Minimal info to console in initrd.
  boot.initrd.verbose = false;

  # Lowest boot console log level
  boot.consoleLogLevel = 0;

  # Silent boot splash
  boot.kernelParams = [ "quiet" "udev.log_level=3" ];

}
