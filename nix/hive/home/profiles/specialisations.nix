{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  # TODO: fzf interface to select generation
  home-manager-generation-path = pkgs.writeShellApplication {
    name = "home-manager-generation-path";
    runtimeInputs = [pkgs.home-manager pkgs.choose];
    text = ''
      gen="-''${1:-1}"
      ${lib.getExe pkgs.home-manager} generations | head $gen | ${
        lib.getExe pkgs.choose
      } -1
    '';
  };
  # TODO: fzf interface to select specialisation & generation
  home-manager-specialisation = pkgs.writeShellApplication {
    name = "specialisation-home-manager";
    runtimeInputs = [
      # Do I need to include runtimeInputs of dep scripts?
      home-manager-generation-path
      pkgs.choose
      pkgs.home-manager
    ];
    text = ''
      spec="$1"; shift 1
      action="''${1:-activate}"; shift 1
      $(home-manager-generation-path)/specialisation/$spec/$activate
    '';
  };
  nixos-specialisation = pkgs.writeShellApplication {
    name = "specialisation-nixos";
    runtimeInputs = [pkgs.nixos-rebuild];
    text = ''
      spec="$1"; shift 1
      sudo nixos-rebuild --specialisation "$spec" $@
    '';
  };
in {
  home.shellAliases = {
    hm-generation-path = "${pkgs.getExe home-manager-generation-path}";
    specialisation-hm = "${pkgs.getExe home-manager-specialisation}";
    specialisation-nixos = "${pkgs.getExe nixos-specialisation}";
  };

  specialisation.secrets-none.configuration = {
    disabledModules = [
      inputs.agenix.homeManagerModules.agenix
      inputs.sops-nix.homeManagerModules.sops
      inputs.scalpel.homeManagerModules.scalpel
    ];

    # TODO: Disable secret modules' activationScript instead of removing the modules.
  };
}
