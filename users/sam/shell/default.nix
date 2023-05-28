{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./bash
    #./fish
    #./nushell
    ./zsh
  ];

  # TODO: Set in system (NixOS | nix-darwin) config
  #environment.pathsToLink = [
  #  "/share/bash-completion"
  #];
}
