{ inputs, config, lib, pkgs, ... }:
{
  # Writes Nix configuration flake to ~/.config/nixos
  xdg.configFile.nixos = {
    enable = true;
    executable = false;
    recursive = true;
    source = inputs.self;
    #onChange = "";
    target = "nixos-cfg";
  };
  home = {
    sessionVariables = {
      NIX_FLAKE_HOME = "${config.xdg.configHome}/nixos";
    };
  };
}
