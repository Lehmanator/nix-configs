{ inputs, cell, config, lib, pkgs, ... }:
{
  imports = with cell.homeProfiles; [ abook bat
    cachix-agent editorconfig eza direnv distrobox
    documentation fetchers fonts fzf git-base gpg
    #helix
    helm ibus k9s lang-nodejs lang-python lang-rust
    ls lsd navi neovim
    #nix.default
    ollama pls recoll ripgrep shell-base shell-aliases
    social-dl social-sleuth starship tmux vm xdg
    #./apps #./gnome
    role-developer role-admin-activedirectory
    role-admin-azure role-admin-windows.all
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
