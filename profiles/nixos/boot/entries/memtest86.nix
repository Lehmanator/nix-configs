{ config, lib, pkgs, ... }:
{
  boot.loader = {
    grub.memtest86 = {
      enable = lib.mkDefault config.boot.loader.grub.enable;
      params = [
        #"console=tty50" # # Setup serial console.
        #"btrace" #        # Enable boot trace
        #"maxcpus=N" #     # Limit number of CPUs
        #"onepass" #       # Run one pass & exit if no errors
        #"tstlist=0,1,2" # # List of tests to run.
        #"cpumask=..." #   # Set a CPU mask to select CPUs to use for testing.
      ];
    };

    systemd-boot.memtest86 = {
      enable = lib.mkDefault config.boot.loader.systemd-boot.enable;
      entryFilename = "zz-memtest86";
    };

  };
}
