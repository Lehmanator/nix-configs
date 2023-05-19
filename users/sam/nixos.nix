{
  self, inputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [ ./nix.nix ];
  programs.nix-ld.enable = true;
}
