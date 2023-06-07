{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./common

    #./bash
    #./fish
    #./nushell
    ./zsh
  ];

  # TODO: Set in system (NixOS | nix-darwin) config
  #environment.pathsToLink = [
  #  "/share/zsh"
  #  "/share/bash-completion"
  #];
}
