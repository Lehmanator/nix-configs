{ inputs, config, lib, pkgs, ... }:
{
  # https://github.com/numtide/system-manager
  #
  # Use system-manager:
  #
  # $ nix run 'github:numtide/system-manager' -- switch --flake '.'
  #
  # Flake.nix outputs:
  #
  # systemConfigs.default = system-manager.lib.makeSystemConfig {
  #   modules = [
  #     ./modules
  #   ];
  # };

  imports = [
    "${inputs.self}/sm/profiles/arch_aarch64-linux.nix"
    "${inputs.self}/sm/profiles/mobile.nix"
    "${inputs.self}/sm/profiles/os_postmarketos.nix"
    "${inputs.self}/sm/profiles/phosh.nix"
  ];

  system-manager.allowAnyDistro = true;
  nixpkgs.hostPlatform = "aarch64-linux";

  environment.systemPackages = [
    pkgs.home-manager
  ];
}
