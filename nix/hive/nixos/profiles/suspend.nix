{ lib, config, pkgs, ... }:
{
  systemd.sleep.extraConfig = lib.mkDefault "HibernateDelaySec=60m"; # Delay hibernate 60min after sleep.
  services.logind.extraConfig = ''
    HandlePowerKey=suspend-then-hibernate
    IdleAction=suspend-then-hibernate
    IdleActionSec=10m
  '';

  # TODO: Enable everything necessary for hibernate
  # - [ ] Swap (>1x RAM size)
  # - [ ] Kernel param: `boot.kernelParams=["resume_offset=<offset_sz>"];`
  #   - How does this work with BTRFS subvolumes?
  #   - How does this work with LUKS encryption?
  # - [ ] Kernel module?: ``
}
