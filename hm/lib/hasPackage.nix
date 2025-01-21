{ config, lib, pkgs, ... }@moduleArgs:
  #
  # Determines if a package is installed in either the home-manager or NixOS system environment.
  #
  # TODO: Handle system environments: nix-darwin, nix-on-droid
  #
  pname: 
    let
      package = if builtins.isString pname then pkgs.${pname} else pname;
      systemPackages = (lib.attrByPath ["environment" "systemPackages"] [] (moduleArgs.osConfig or {}));
    in
    (builtins.elem package config.home.packages) || 
    (builtins.elem package       systemPackages)
