{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}:
#let
#  mkUser = username: {
#    isNormalUser = true;
#    group = "users";
#    extraGroups = ["dialout"];
#  };
#in
{
  imports = with inputs; [
    #self.nixosProfiles.home-manager #./home-manager.nix
    self.nixosProfiles.user-primary
  ];
}
