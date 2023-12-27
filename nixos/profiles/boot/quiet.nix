{ inputs
, config
, lib
, pkgs
, ...
}:
{
  boot = {
    # Silent boot splash
    kernelParams = [ "quiet" "loglevel=3" "systemd.show_status=auto" "udev.log_level=3" "rd.udev.log_level=3" "vt.global_cursor_default=0" ];
    consoleLogLevel = 0; # Lowest boot console log level
    initrd.verbose = false; # Minimal info to console in initrd.
  };
  console = {
    useXkbConfig = true;
    earlySetup = false;
  };
}
