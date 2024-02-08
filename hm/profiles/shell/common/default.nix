{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  imports = [
    ./abook.nix
    ./alias.nix
    #./audio.nix
    #./colors.nix
    ./direnv.nix
    ./fetchers.nix
    ./fzf.nix
    ./ls.nix
    ./navi.nix
    #./readline.nix
    ./ripgrep.nix
    ./starship.nix
    ./tmux.nix
    ../../docs
    ../../pager
  ];

  programs.bash = {
    enableVteIntegration = true;
    historyControl = ["ignorespace"];
  };

  # TODO: Move to separate file
  programs.command-not-found.enable = !config.programs.direnv.enable;
  services.lorri.enable = !config.programs.direnv.nix-direnv.enable;

  home.packages = [
    #pkgs.uutils-coreutils #        # Rust rewrite of GNU coreutils WITH prefix
    pkgs.uutils-coreutils-noprefix # Rust rewrite of GNU coreutils WITHOUT prefix

    pkgs.cmatrix # Cool matrix screensaver program
    pkgs.figlet # Print ASCII art text
    pkgs.nix-zsh-completions # Completions for Nix, NixOS, NixOps, & ecosystem
    pkgs.with-shell # Interactive shell where each command starts with cmd prefix
    pkgs.zsh-nix-shell # ZSH plugin that lets you use ZSH in nix-shell
  ];
}
