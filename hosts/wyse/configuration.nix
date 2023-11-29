{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    #./hardware-configuration.nix
    ../../profiles/adb.nix
    ../../profiles/boot
    ../../profiles/desktop
    ../../profiles/desktop/de/gnome
    #../../profiles/editor
    #../../profiles/hardware/display/displaylink.nix
    ../../profiles/hardware/fwupd.nix
    ../../profiles/hardware/peripherals/logitech.nix
    #../../profiles/hardware/tpm1.2.nix
    ../../profiles/hardware/usb.nix
    ../../profiles/locale
    ../../profiles/network
    ../../profiles/nixos
    ../../profiles/security/polkit.nix
    ../../profiles/security/sops.nix
    ../../profiles/shell
    ../../profiles/sshd.nix
    ../../profiles/users
    ../../profiles/virt
    #../../profiles/virt/windows
  ];
  system.stateVersion = "23.11"; # Did you read the comment?
  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
    #"aarch64-darwin" "x86_64-darwin"
  ];
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  console.useXkbConfig = true;
  hardware.enableAllFirmware = true;
  networking.hostName = "wyse";
  users.users.${user} = {
    isNormalUser = true;
    description = "Sam Lehman";
    extraGroups = [ "wheel" "users" "dialout" ];
  };
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
