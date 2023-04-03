{
  self,
  inputs,
  system,
  host, userPrimary,
  config, lib, pkgs,
  ...
}:
let
in
{
  # TODO: Abstract out sudo program
  environment.shellAliases = {
    ctl = "systemctl";
    sctl = "sudo systemctl";

    s = lib.mkIf config.security.sudo.enable "sudo";
    pk = "pkexec";

    nbuild = "sudo nixos-rebuild switch";
    nbuildvm = "sudo nixos-rebuild switch";
    nswitch = "sudo nixos-rebuild switch";
    nswitchdry = "sudo nixos-rebuild switch";
    ntest = "sudo nixos-rebuild test";
  };
}
