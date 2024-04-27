{ inputs, config, lib, pkgs, ... }:
{
  security = {
    audit.enable = lib.mkDefault true;
    auditd.enable = lib.mkDefault true;
  };
}
