{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    inputs.nixos-flatpak.homeManagerModules.default
    ./crypto
    ./apps
    ./gnome
    ./editor
    ./fonts.nix
    ./git
    ./languages/nodejs.nix
    ./languages/python.nix
    ./languages/rust.nix
    ./nix
    ./roles/dev
    ./roles/sysadmin
    ./search
    ./shell
    ./social
    ./sops.nix
    ./virt
    ./xdg.nix
    #../../profiles/workarounds.nix
    # TODO: Conditionally load ./nixos.nix when system is NixOS-based
  ];

  #home.stateVersion = "23.05";
  home.stateVersion = "23.11";
  home.enableDebugInfo = true;
  home.enableNixpkgsReleaseCheck = true;
  #home.extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];
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
    pkgs.repgrep # Interactive replacer for ripgrep

    #pkgs.python311Full
    #pkgs.python312
    #pkgs.python311
    #pkgs.python310

    pkgs.ntfs3g
    #pkgs.rustup
  ];
}
