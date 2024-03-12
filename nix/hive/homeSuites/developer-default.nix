{ inputs, cell, nixosConfig, osConfig, config, lib, pkgs, ... }: {
  imports = [
    cell.homeProfiles.abook
    cell.homeProfiles.bat
    cell.homeProfiles.cachix-agent
    cell.homeProfiles.editorconfig
    cell.homeProfiles.eza
    cell.homeProfiles.direnv
    cell.homeProfiles.distrobox
    cell.homeProfiles.documentation
    cell.homeProfiles.fetchers
    cell.homeProfiles.fonts
    cell.homeProfiles.fzf
    cell.homeProfiles.git
    cell.homeProfiles.gpg
    cell.homeProfiles.helix
    cell.homeProfiles.helm
    cell.homeProfiles.k9s
    cell.homeProfiles.lang-nodejs
    cell.homeProfiles.lang-python
    cell.homeProfiles.lang-rust
    cell.homeProfiles.ls
    cell.homeProfiles.lsd
    cell.homeProfiles.navi
    cell.homeProfiles.neovim
    cell.homeProfiles.nix
    cell.homeProfiles.ollama
    cell.homeProfiles.pls
    cell.homeProfiles.recoll
    cell.homeProfiles.ripgrep
    cell.homeProfiles.shell-base
    cell.homeProfiles.shell-aliases
    cell.homeProfiles.social-dl
    cell.homeProfiles.social-sleuth
    cell.homeProfiles.starship
    cell.homeProfiles.tmux
    cell.homeProfiles.vm
    cell.homeProfiles.xdg

    #./apps
    #./gnome

    cell.homeProfiles.role-developer
    cell.homeProfiles.role-admin-activedirectory
    cell.homeProfiles.role-admin-azure
    cell.homeProfiles.role-admin-windows
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
      pkgs.ntfs3g
      #pkgs.rustup

      # TODO: Fix
      #inputs.self.packages.${pkgs.system}.system-repl
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
