{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #inputs.home-extra-xhmm.homeManagerModules.console.program-variables
    #inputs.home-extra-xhmm.homeManagerModules.console.fish
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

  # home = {
  #   editor = {
  #     executable = types.path | types.str;
  #     package = types.package;
  #   };
  #   visual = { ... };
  #   pager = { ... };
  # };
  # programs.nano = {
  #   enable = false;
  #   package = types.package;
  #   config = ''
  #     // contents of .nanorc //
  #   '';
  # };
  # programs.fish.prompt = types.str;
}
