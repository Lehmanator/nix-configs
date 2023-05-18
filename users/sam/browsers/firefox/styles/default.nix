
{ self, inputs,
  config, lib, pkgs,
  ...
}:
{
  userChrome = (import ./chrome/default.nix);
  userContent = (import ./content/default.nix);
}
