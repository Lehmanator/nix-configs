{ config, lib, pkgs, ... }@args:
let cfg = config.debug;
in {
  #imports = [ ];
  options = { enable = lib.mkEnableOption "NixOS Debugging"; };

  config = lib.mkIf cfg.enable {
    environment.etc = {
      # TODO: Figure out how to pretty-print tree of attrs.
      # TODO: Figure out how to restrict attrset depth.
      "nix/debug/module-args.txt".text =
        lib.concatStringsSep "\n" (builtins.attrNames args);
      "nix/debug/flake-inputs.txt".text =
        lib.concatStringsSep "\n" (builtins.attrNames args.inputs);
    };
  };
}
