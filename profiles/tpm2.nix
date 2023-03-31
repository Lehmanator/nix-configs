{
  self,
  system,
  userPrimary,
  inputs,
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [
  ];

  security.tpm2.enable = true;
  #security.tpm2.abrmd.enable = true;
  security.tpm2.pkcs11.enable = true;

  #services.tcsd.enable = true;

  users.extraGroups.tss = { name = "tss"; members = [ "sam" ]; };
}
