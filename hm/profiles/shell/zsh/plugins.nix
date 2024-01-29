{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    prezto = {
      enable = false;

      # Extra ZSH stuff to load. See:
      # - Functions: `$ man zshcontrib`
      # - Modules:   `$ man zshmodules`
      extraFunctions = ["zargs" "zmv"];
      extraModules = ["attr" "stat"];

      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"
        "completion"
        "prompt"
      ];

      # TODO: Separate personal keys from profile-related config.
      # TODO: mkSshIdentities = name: ["id_${name}_rsa" "id_${name}_ed25519"];
      ssh.identities = [
        "id_rsa"
        "id_ed25519"
        "id_lehmanator_ed25519"
        "id_slehman_ed25519"
        "id_slehman_rsa"
      ];
    };

    # TODO: Fetch plugins using nvfetcher & nixpkgs overlay ?
    plugins = [
      #pkgs.zsh-fzf-tab

      # Use ZSH inside nix-shell
      #{name="zsh-nix-shell"; file="nix-shell.plugin.zsh"; src=pkgs.fetchFromGitHub {owner="chisui"; repo="zsh-nix-shell"; rev="v0.7.0"; hash="sha256-oQpYKBt0gmOSBgay2HgbXiDoZo5FoUKwyHSlUrOAP5E=";}; }
    ];
  };

  home.packages = [ pkgs.zsh-fzf-tab ];
}
