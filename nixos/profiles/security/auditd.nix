
{ inputs, config, lib, pkgs, ... }:
{
  imports = [
  ];

  security = {
    audit.enable = lib.mkDefault true;
    auditd.enable = true;
  };
}
