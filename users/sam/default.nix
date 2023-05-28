{ self
, system
, modulesPath
, inputs
, outputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./browsers
    ./editor
    ./fonts.nix
    ./git
    ./gnome
    ./gpg.nix
    ./languages/nodejs.nix
    ./nix.nix
    ./shell/zsh
    ./social
    ./xdg.nix
    ../../profiles/workarounds.nix
    # TODO: Conditionally load ./nixos.nix when system is NixOS-based
  ];

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;
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

  home.packages = with pkgs; [
    bitwarden
    cmatrix
  ];

  programs.home-manager.enable = true;
  services.home-manager.autoUpgrade.enable = true;
  services.home-manager.autoUpgrade.frequency = "weekly";
}
