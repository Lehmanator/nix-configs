{ inputs, config, lib, pkgs, ... }:
{
  # imports = [inputs.nixpkgs-gnome-apps.nixosModules.default];  # No NixOS module, only overlay
  programs.calls.enable = true;
  environment.systemPackages = [
    pkgs.chatty #        # IM & SMS
    pkgs.epiphany #      # Web Browser
    pkgs.gnome-console # # Terminal
    pkgs.megapixels #    # Camera
    pkgs.git #           # For rebuilding w/ GitHub flakes
  ] ++ (with inputs.snowflakeos.packages.${pkgs.system}; [
    nix-software-center
    nixos-conf-editor
    snowflakeos-module-manager
    snowfall-lib
  ]);
}
