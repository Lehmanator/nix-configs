{ inputs
, self
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./apparmor.nix
  ];

  services.dbus.apparmor = "enabled"; # enabled | disabled | required
  security = {
    apparmor.enable = true;
    audit.enable = lib.mkDefault true;
    auditd.enable = true;
    protectKernelImage = true;
  };
}
