{
  inputs,
  nixosConfig,
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs) system;
  #system = pkgs.system;
  arch = lib.lists.elemAt (lib.strings.splitString "-" system) 0;
  platform = lib.lists.elemAt (lib.strings.splitString "-" system) 1;
in {
  imports = [
    ./modules

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
    ./virt
    ./xdg.nix
    ./cachix-agent.nix

    # TODO: Conditionally load ./nixos.nix when system is NixOS-based
    #./_system/${system}
    #./_arch/${arch}
    #./_platform/${platform}
    #./_host/${osConfig.networking.hostName}
  ];

  home = {
    stateVersion = "23.11";
    enableDebugInfo = true;
    enableNixpkgsReleaseCheck = true;
    #extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];
    sessionPath = with config.xdg.userDirs.extraConfig; [
      XDG_APPS_DIR
      XDG_BIN_DIR
    ];
    packages = [
      #pkgs.ripgrep-all   # Fast grep w/ ability to search in PDFs, eBooks, Office docs, archives, & more
      pkgs.repgrep # Interactive replacer for ripgrep

      #pkgs.python311Full
      #pkgs.python312
      #pkgs.python311
      #pkgs.python310

      pkgs.ntfs3g
      #pkgs.rustup
    ];
  };

  programs = {
    ripgrep.enable = true;
    home-manager.enable = true;
  };

  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "weekly";
  };
}
