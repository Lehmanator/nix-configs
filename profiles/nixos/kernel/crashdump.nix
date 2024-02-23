{
  lib,
  config,
  pkgs,
  ...
}: {
  boot.kernelPatches = [
    {
      name = "crashdump-config";
      patch = null;
      extraConfig = ''
        CRASH_DUMP y
        DEBUG_INFO y
        PROC_VMCORE y
        LOCKUP_DETECTOR y
        HARDLOCKUP_DETECTOR y
      '';
    }
  ];
}
