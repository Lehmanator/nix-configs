{ config, lib, pkgs, ... }:
{
  imports = [
    ./modules

    ./cachix-agent.nix
    ./crypto
    ./direnv.nix
    ./apps
    ./gnome
    ./editorconfig.nix
    ./fonts.nix
    ./git
    ./helix
    ./languages
    ./manix.nix
    ./nix
    ./ollama.nix
    ./roles/dev
    ./roles/sysadmin
    ./search
    ./shell
    ./social
    ./ssh.nix
    ./virt
    ./xdg.nix

    # ./codium
    # ./neovim
    # ./nixvim
  ];

  home = {
    stateVersion = "23.11";
    enableDebugInfo = true;
    enableNixpkgsReleaseCheck = true;
    #extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];
    sessionPath = with config.xdg.userDirs.extraConfig; [ XDG_APPS_DIR XDG_BIN_DIR ];
    packages = [
      #pkgs.ripgrep-all   # Fast grep w/ ability to search in PDFs, eBooks, Office docs, archives, & more
      pkgs.repgrep        # Interactive replacer for ripgrep
      #pkgs.python3
      #pkgs.python311Full
      #pkgs.python312

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

  systemd.user = {
    # Start new/changed services wanted by active targets & stop obsolete services from prev generation
    # - "suggest"   / false = print suggested systemctl commands to run manually
    # - "sd-switch" / true  = use sd-switch to determine necessary changes & apply them
    # - "legacy"            = Use Ruby script to determine necessary changes & apply them. Will be removed soon.
    startServices = true;  

    # Environment variables that will be set for the user session.
    #   The variable values must be as described in environment.d(5).
    # sessionVariables = config.home.sessionVariables;

    # # Extra config options for user session service manager. 
    # # https://www.freedesktop.org/software/systemd/man/systemd-user.conf.html
    # settings = {
    #   Manager = rec {

    #     # Sets environment variables just for the manager process itself.
    #     ManagerEnvironment = DefaultEnvironment;

    #     # Configures environment variables passed to all executed processes.
    #     DefaultEnvironment = {
    #       PATH = "%u/bin:%u/.cargo/bin";
    #     };
    #   };
    # };
  };
}
