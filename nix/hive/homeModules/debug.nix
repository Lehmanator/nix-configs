{ config, lib, pkgs, ... }@args:
let
  inherit (args) config lib;
  inherit (lib) concatStringsSep mkEnableOption mkIf;
  cfg = config.debug;
in
{
  imports = [ ];

  options.debug = { enable = mkEnableOption "NixOS Debugging"; };

  config = mkIf cfg.enable {
    xdg.configFile = {
      # TODO: Figure out how to pretty-print tree of attrs.
      # TODO: Figure out how to restrict attrset depth.
      "nix/debug/module-args.txt".text =
        concatStringsSep "\n" (builtins.attrNames args);
      "nix/debug/flake-inputs.txt".text =
        concatStringsSep "\n" (builtins.attrNames args.inputs);
    };
  };
}
