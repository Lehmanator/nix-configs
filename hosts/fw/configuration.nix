# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ 
  self,
  system,
  host, userPrimary,
  inputs,
  config, lib, pkgs,
  ...
}:

{
  imports = [
    # Include SnowflakeOS config
    ./snowflake.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Activate profiles
    ../../profiles/activedirectory/admin.nix
    ../../profiles/adb.nix
    ../../profiles/emu-windows.nix
    ../../profiles/flatpak.nix
    ../../profiles/fprintd.nix
    ../../profiles/gnome.nix
    ../../profiles/locale-est.nix
    ../../profiles/nixos.nix
    ../../profiles/pipewire.nix
    ../../profiles/polkit.nix
    ../../profiles/shell-zsh.nix
    ../../profiles/tpm2.nix
    ../../profiles/user-defaults.nix
    ../../profiles/virt-vm-host.nix

    # Include configuration managed by apps:
    # - nixos-conf-editor
    # - nix-software-center
    ./managed.nix
  ];

  # --- Bootloader ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # --- Network ---
  # Define your hostname.
  networking.hostName = "fw";

  # --- Mail ---
  services.davmail.enable = true;
  services.davmail.url = "https://outlook.office365.com/EWS/Exchange.asmx";
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # --- Users ---
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."sam" = {
    isNormalUser = true;
    description = "Sam Lehman";
    extraGroups = [ "wheel" "users" "dialout" ];
  };
  programs.fuse.userAllowOther = true;

  hardware.enableAllFirmware = true;
  hardware.opengl.driSupport32Bit = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    bat
    exa
    firefox
    gcc
    lsd
    neofetch
    ripgrep
    tealdeer

    gnumake

    # --- Security ---
    lynis

  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  # --- Docs ---
  documentation.doc.enable = true;
  documentation.dev.enable = true;
  documentation.man.generateCaches = true;
  documentation.info.enable = true;
  documentation.nixos.enable = true;
  #documentation.nixos.includeAllModules = true;

  #programs.home-manager.enable = true;

  # --- Shell ---
  programs.git.enable = true;
  programs.git.package = pkgs.gitFull;
  programs.fzf.fuzzyCompletion = true;
  programs.fzf.keybindings = true;
  programs.less.enable = true;
  programs.less.lessopen = "|${pkgs.lesspipe}/bin/lesspipe.sh %s";
  programs.starship.enable = true;
  programs.traceroute.enable = true;

  # --- Browsers ---
  programs.chromium.enable = true;
  programs.chromium.defaultSearchProviderEnabled = true;
  programs.firefox.enable = true;

  # --- Keys ---
  programs.gnupg.dirmngr.enable = true;
  programs.gnupg.agent.enableExtraSocket = true;
  programs.gnupg.agent.enableBrowserSocket = true;


  # --- Theme ---
  qt.enable = true;

  # --- Nix ---
  nix.settings.trusted-public-keys = [
    "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
    "snowflakeos.cachix.org-1:gXb32BL86r9bw1kBiw9AJuIkqN49xBvPd1ZW8YlqO70="
  ];
}
