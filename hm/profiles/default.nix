{ config, lib, pkgs, ... }:
{
  imports = [
    ./modules

    ./apps
    ./git
    ./gnome
    ./helix
    ./languages
    ./nix
    ./roles/dev
    ./roles/sysadmin
    ./zsh

    ./abook.nix
    ./bash.nix
    ./bat.nix
    ./cachix-agent.nix
    ./compat.nix
    ./crypto.nix
    ./dircolors.nix
    ./direnv.nix
    ./distrobox.nix
    ./editorconfig.nix
    ./eza.nix
    ./fastfetch.nix
    ./fd.nix
    ./fonts.nix
    ./fzf.nix
    ./gallery-dl.nix
    ./gpg.nix
    ./home-manager.nix
    ./hyfetch.nix
    ./lsd.nix
    ./manix.nix
    ./media.nix
    ./navi.nix
    ./ollama.nix
    ./playerctld.nix
    ./pls.nix
    ./readline.nix
    ./recoll.nix
    ./ripgrep.nix
    ./sftpman.nix
    ./shell.nix
    ./skim.nix
    ./ssh.nix
    ./starship.nix
    ./tealdeer.nix
    ./tmux.nix
    ./vm.nix
    ./xdg.nix

    # ./codium
    # ./neovim
    # ./nixvim

    # ./emanote.nix
    # ./nextcloud.nix
  ];

  home = {
    stateVersion = "23.11";
    #extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];
    shellAliases = {
      # --- Directory Navigation ---
      # TODO: Use lib to extend for any number of dots.
      ".."    = "cd ..";
      "..."   = "cd ...";
      "...."  = "cd ....";
      "....." = "cd .....";
      mkd = "mkdir -p";

      # --- Files ---
      c = "cat";
      e = "$EDITOR";      edit="$EDITOR";
      v = "$VISUAL";      vedit="$VISUAL";
      s = "$SUDO_EDITOR"; sedit="$SUDO_EDITOR";
      web = "$BROWSER";  # TODO: CLI vs GUI

      # --- Programs ---
      w = "which -a";
      # path-print-nix = "echo \"$NIX_PATH\" | tr ':' '\n'";  # TODO: Properly escape
      # path-print     = "echo \"$PATH\" | tr ':' '\n'";

      # --- Terminal ---
      cl = "clear";
      she = "$SHELL";

      # --- Networking ---
      ip-address = "curl ifconfig.me";

      # --- Privileges -------------
      #s  = lib.mkIf config.security.sudo.enable "sudo";        # TODO: Make generic
      #pk = lib.mkIf config.security.policyKit.enable "pkexec"; # TODO: Reference NixOS config
    };
    
    packages = [
      #pkgs.uutils-coreutils         # Rust rewrite of GNU coreutils WITH prefix
      pkgs.uutils-coreutils-noprefix # Rust rewrite of GNU coreutils WITHOUT prefix

      pkgs.cmatrix                   # Cool matrix screensaver program
      pkgs.figlet                    # Print ASCII art text

      pkgs.ntfs3g
      #pkgs.rustup
      #pkgs.python3
      #pkgs.python311Full
      #pkgs.python312
    ];
  };

  programs.man.generateCaches = true;  # Disabled by default bc slows builds.

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
