{ inputs, nixosConfig, osConfig, config, lib, pkgs, ... }: {
  imports = [
    inputs.self.homeProfiles.abook
    inputs.self.homeProfiles.bat
    inputs.self.homeProfiles.cachix-agent
    inputs.self.homeProfiles.editorconfig
    inputs.self.homeProfiles.eza
    inputs.self.homeProfiles.direnv
    inputs.self.homeProfiles.distrobox
    inputs.self.homeProfiles.documentation
    inputs.self.homeProfiles.fetchers
    inputs.self.homeProfiles.fonts
    inputs.self.homeProfiles.fzf
    inputs.self.homeProfiles.git
    inputs.self.homeProfiles.gpg
    inputs.self.homeProfiles.helix
    inputs.self.homeProfiles.helm
    inputs.self.homeProfiles.k9s
    inputs.self.homeProfiles.lang-nodejs
    inputs.self.homeProfiles.lang-python
    inputs.self.homeProfiles.lang-rust
    inputs.self.homeProfiles.ls
    inputs.self.homeProfiles.lsd
    inputs.self.homeProfiles.navi
    inputs.self.homeProfiles.neovim
    inputs.self.homeProfiles.nix
    inputs.self.homeProfiles.ollama
    inputs.self.homeProfiles.pls
    inputs.self.homeProfiles.recoll
    inputs.self.homeProfiles.ripgrep
    inputs.self.homeProfiles.shell-base
    inputs.self.homeProfiles.shell-aliases
    inputs.self.homeProfiles.social-dl
    inputs.self.homeProfiles.social-sleuth
    inputs.self.homeProfiles.starship
    inputs.self.homeProfiles.tmux
    inputs.self.homeProfiles.vm
    inputs.self.homeProfiles.xdg

    #./apps
    #./gnome

    inputs.self.homeProfiles.role-developer
    inputs.self.homeProfiles.role-admin-activedirectory
    inputs.self.homeProfiles.role-admin-azure
    inputs.self.homeProfiles.role-admin-windows
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
