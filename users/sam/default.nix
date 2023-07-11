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
    ./shell
    ./social
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
}
