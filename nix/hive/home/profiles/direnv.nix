{ config, lib, pkgs, user, ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      global = { load_dotenv = true; };
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
}
