{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./abook.nix
    ./alias.nix
    ./fzf.nix
    ./ls.nix
    ./navi.nix
    ../../docs
    ../../pager
  ];
  programs.bash = {
    enableVteIntegration = true;
    historyControl = [ "ignorespace" ];
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.command-not-found.enable = !config.programs.direnv.enable;
  services.lorri.enable = !config.programs.direnv.nix-direnv.enable;
  programs.starship = {
    enable = true;
    enableTransience = true;
  };
  home.packages = [
    pkgs.cmatrix # Cool matrix screensaver program
    pkgs.figlet # Print ASCII art text
    pkgs.nix-zsh-completions # Completions for Nix, NixOS, NixOps, & ecosystem
    pkgs.with-shell # Interactive shell where each command starts with cmd prefix
    pkgs.zsh-nix-shell # ZSH plugin that lets you use ZSH in nix-shell
  ];
}
