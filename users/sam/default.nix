{ self , inputs
, config , lib , pkgs
, ...
}:
{
  imports = [
    ./crypto
    ./desktop/apps
    ./desktop/gnome
    ./editor
    ./fonts.nix
    ./git
    ./languages/nodejs.nix
    ./nix
    ./roles/dev
    ./roles/sysadmin
    ./search
    ./shell
    ./social
    ./vm.nix
    ./xdg.nix
    ../../profiles/workarounds.nix
    # TODO: Conditionally load ./nixos.nix when system is NixOS-based

    # --- Devices ---
    #./devices/flame.nix
    #./devices/cheetah.nix
    ./devices/pinetime.nix
    ./devices/sawfish.nix
  ];

  nixpkgs.overlays = [
    inputs.nur.overlay
  ];

  home.stateVersion = "23.05";
  home.enableDebugInfo = true;
  home.enableNixpkgsReleaseCheck = true;
  home.extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];
  home.sessionPath = [
    config.xdg.userDirs.extraConfig.XDG_APPS_DIR
    config.xdg.userDirs.extraConfig.XDG_BIN_DIR
  ];

  programs.home-manager.enable = true;
  services.home-manager.autoUpgrade.enable = true;
  services.home-manager.autoUpgrade.frequency = "weekly";

  programs.ripgrep.enable = true;
  home.packages = [
    #pkgs.ripgrep-all   # Fast grep w/ ability to search in PDFs, eBooks, Office docs, archives, & more
    pkgs.repgrep       # Interactive replacer for ripgrep

    #pkgs.python311Full
    #pkgs.python312
    #pkgs.python311
    #pkgs.python310

    pkgs.ntfs3g
    pkgs.rustup
  ];
}
