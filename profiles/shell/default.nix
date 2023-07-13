{ self, inputs
, config, lib, pkgs
, user
, ...
}:
{
  imports = [
    ./zsh.nix
  ];
  users.defaultUserShell = pkgs.zsh;

  environment.pathsToLink = [
    "/share/zsh"
  ];

  # --- Prompt -------------------------------------------------------
  #programs.starship = { # Prompt for Bash & ZSH
  #  enable = true;
  #  interactiveOnly = false;  # Some plugins require this to be set to false to function correctly. Default=true
  #  #settings = {};
  #};
}
