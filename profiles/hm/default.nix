{ inputs
, osConfig
, config
, lib
, pkgs
, ...
}:
let
  system = pkgs.system;
  arch = lib.lists.elemAt (lib.strings.splitString "-" system) 0;
  platform = lib.lists.elemAt (lib.strings.splitString "-" system) 1;
in
{
  imports = [
    inputs.nixos-flatpak.homeManagerModules.default
    ../../users/crypto
    ../../users/apps
    ../../users/gnome
    ../../users/editor
    ../../users/fonts.nix
    ../../users/git
    ../../users/languages/nodejs.nix
    ../../users/languages/python.nix
    ../../users/languages/rust.nix
    ../../users/nix
    ../../users/roles/dev
    ../../users/roles/sysadmin
    ../../users/search
    ../../users/shell
    ../../users/social
    ../../users/sops.nix
    ../../users/virt
    ../../users/xdg.nix

    # TODO: Conditionally load ./nixos.nix when system is NixOS-based
    ./system/${system}
    ./arch/${arch}
    ./platform/${platform}
    #./host/${osConfig.networking.hostName}
  ];

  home = {
    stateVersion = "23.11";
    enableDebugInfo = true;
    enableNixpkgsReleaseCheck = true;
    #extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];
    sessionPath = with config.xdg.userDirs.extraConfig; [ XDG_APPS_DIR XDG_BIN_DIR ];
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
