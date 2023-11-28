{ inputs, self
, config, lib, pkgs
, user
, ...
}:
#let
#  mkUser = username: {
#    isNormalUser = true;
#    group = "users";
#    extraGroups = ["dialout"];
#  };
#in
{
  imports = [
    #./home-manager.nix
    ./primary.nix
  ];
}
