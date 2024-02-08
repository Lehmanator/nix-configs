{
  pkgs,
  lib,
  ...
}: {
  # Last Update: 2024/02/06
  programs.zsh.plugins = [
    {
      name = "zsh-nix-shell";
      src = pkgs.fetchFromGitHub {
        owner = "";
        repo = "zsh-nix-shell";
        rev = "";
        hash = lib.fakeHash;
      };
      file = "zsh-nix-shell.zsh";
    }
  ];
}
