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
    ./fetchers.nix
    ./fzf.nix
    ./ls.nix
    ./navi.nix
    #./readline.nix
    ./tmux.nix
    ../../docs
    ../../pager
  ];

  programs.bash = {
    enableVteIntegration = true;
    historyControl = ["ignorespace"];
  };

  # TODO: Move to separate file
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = {load_dotenv = true;};
      whitelist = {
        prefix = [
          "/home/${user}/Code/Lehmanator" # Trust my personal projects
          "/home/${user}/Code/forks" # # Trust projects I'm forking
        ]; # "${config.xdg.userDirs.custom.}";
        exact = [
          "/home/${user}/.config/nixos/.envrc" # Trust NixOS config repo
        ];
      };
    };
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
