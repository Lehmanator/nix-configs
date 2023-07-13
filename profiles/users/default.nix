{ inputs, self
, config, lib, pkgs
, user
, ...
}:
let
  mkUser = username: {
    isNormalUser = true;
    group = "users";
    extraGroups = ["dialout"];
  };
in
{
  imports = [
    ./primary.nix
  ];

}
