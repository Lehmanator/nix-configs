{
  self,
  system,
  modulesPath,
  inputs, outputs,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    ./browsers/default.nix
    ./editor/neovim.nix
    ./git.nix
    ./gnome/default.nix
    ./shell/zsh.nix
    ./social/default.nix
    ./xdg.nix
  ];

  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nur.overlay
  ];

  home.stateVersion = "23.05";
  home.enableDebugInfo = true;
  home.enableNixpkgsReleaseCheck = true;
  home.extraOutputsToInstall = [ "doc" "info" "devdoc" ];
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
