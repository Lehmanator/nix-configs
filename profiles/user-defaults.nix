{
  self,
  inputs,
  config, lib, pkgs,

  # TODO: Pass this as a variable
  host, userPrimary,
  ...
}:
let
in
{
  imports = [
  ];

  users.defaultUserShell = pkgs.zsh;
}
