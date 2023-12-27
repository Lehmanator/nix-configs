{ inputs
, config
, lib
, pkgs
, user
, modulesPath
, ...
}:
{
  system.stateVersion = "23.11"; # Did you read the comment?
  boot.binfmt.emulatedSystems = [
    "aarch64-linux" #"aarch64-darwin" "x86_64-darwin"
  ];
  #boot.loader.efi.efiSysMountPoint = "/boot/efi";
  console.useXkbConfig = true;
  hardware.enableAllFirmware = true;
  networking.hostName = "wyse";
  users.users.${user} = {
    isNormalUser = true;
    description = "Sam Lehman";
    extraGroups = [ "wheel" "users" "dialout" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2M80EUw0wQaBNutE06VNgSViVot6RL0O6iv2P1ewWH sam@fw" ];
  };
  #users.users.nixos = {
  #  initialPassword = "nixos-installer-changeme";
  #};
  environment.systemPackages = with pkgs; [
    bat
    eza
    gcc
    lsd
    neofetch
    #ripgrep
    tealdeer
    gnumake
    lynis
  ];
  qt.enable = true;
  nix.settings.trusted-public-keys = [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" ];
  programs = {
    git = { enable = true; package = pkgs.gitFull; };
    less = { enable = true; lessopen = "|${pkgs.lesspipe}/bin/lesspipe.sh %s"; };
    traceroute.enable = true;
    chromium = { enable = true; defaultSearchProviderEnabled = true; };
    #firefox.enable = true;
    gnupg = { dirmngr.enable = true; agent.enableExtraSocket = true; agent.enableBrowserSocket = true; };
  };

}
