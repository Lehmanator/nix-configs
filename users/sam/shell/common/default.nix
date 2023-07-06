{ self
, inputs
, system
, host
, network
, repo
, userPrimary
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ./alias.nix
    ./fzf.nix
    ./ls.nix
    ../../docs
    ../../pager
  ];

  programs.bash = {
    enableVteIntegration = true;
    historyControl = [ "ignorespace" ];
  };

  # --- Direnv / DevShells ----
  services.lorri.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # --- Prompt ---------------
  programs.starship.enable = true;

  # --- Packages -------------
  home.packages = [
    pkgs.cmatrix # Cool matrix screensaver program
    pkgs.figlet # Print ASCII art text
    pkgs.nix-zsh-completions # Completions for Nix, NixOS, NixOps, & ecosystem
    pkgs.with-shell # Interactive shell where each command starts with cmd prefix
    pkgs.zsh-nix-shell # ZSH plugin that lets you use ZSH in nix-shell
  ];

}
