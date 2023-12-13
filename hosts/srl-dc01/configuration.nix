# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ inputs
, config
, lib
, pkgs
, user
, ...
}: {
  system.stateVersion = "23.05"; # Did you read the comment?
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  console.useXkbConfig = true;
  hardware.enableAllFirmware = true;
  networking.hostName = "srl-dc01";

  users.users.${user} = {
    isNormalUser = true;
    description = "Sam Lehman";
    extraGroups = [ "wheel" "users" "dialout" ];
  };
  qt.enable = false;
  programs = {
    git = { enable = true; package = pkgs.gitFull; };
    less = { enable = true; lessopen = "|${pkgs.lesspipe}/bin/lesspipe.sh %s"; };
    traceroute.enable = true;
    chromium.enable = false;
    firefox.enable = true;
    gnupg = { dirmngr.enable = true; agent.enableExtraSocket = true; agent.enableBrowserSocket = true; };
  };
  environment.systemPackages = [ pkgs.bat pkgs.eza pkgs.gcc pkgs.lsd pkgs.neofetch pkgs.tealdeer pkgs.gnumake pkgs.lynis ];
  nix.settings.trusted-public-keys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" ];
}
