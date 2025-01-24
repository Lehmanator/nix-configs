{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
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
    ./sops.nix
    ./ssh.nix
    ./starship.nix
    ./tealdeer.nix
    ./tmux.nix
    ./topgrade.nix
    ./vm.nix
    ./xdg.nix

    ./monado.nix
    ./steam.nix
  ];

  home.homeDirectory = lib.mkDefault (
    (if pkgs.stdenv.isLinux then "/home/" else "/Users/") + config.home.username
  );
  home.stateVersion = "23.11";
  # home.extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];
  home.shellAliases = {
    # --- Directory Navigation ---
    # TODO: Use lib to extend for any number of dots.
    ".." = "cd ..";
    "..." = "cd ...";
    "...." = "cd ....";
    "....." = "cd .....";
    mkd = "mkdir -p";

    # --- Files ---
    c = "cat";
    e = "$EDITOR";
    edit = "$EDITOR";
    v = "$VISUAL";
    vedit = "$VISUAL";
    s = "$SUDO_EDITOR";
    sedit = "$SUDO_EDITOR";
    web = "$BROWSER"; # TODO: CLI vs GUI

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

  home.packages = [
    pkgs.cmatrix # Cool matrix screensaver program
    pkgs.figlet # Print ASCII art text

    pkgs.ntfs3g

    # TODO: Also set PKG_CONFIG_PATH="${lib.getExe pkgs.pkg-config}:$XDG_DATA_HOME/nix/profile/lib/pkg-config"
    pkgs.pkg-config
  ];

  programs.man.generateCaches = true; # Disabled by default bc slows builds.

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

  # TODO: Write: `/var/lib/AccountsService/users/${config.home.username}`
  # TODO: Move to NixOS profile?
  # accountService = ''
  #   [User]
  #   Languages=en_US.UTF-8;
  #   Session=gnome
  #   SessionType=wayland
  #   Icon=/etc/nixos/hm/users/${config.home.username}/profile.png
  #   SystemAccount=false
  # '';
  #
  # xdg.configFile."nixos" = {
  #   source = inputs.self.outPath;
  # };
}
