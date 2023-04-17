## Shell-agnostic configuration
##
##
{
  self,
  inputs,
  system,
  host, network, repo,
  userPrimary,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    ./alias.nix
  ];

  # TODO: Find nix-related program from old config that was better
  # - nix-index
  programs.command-not-found.enable = false;
  programs.thefuck.enable = true;
  programs.thefuck.alias = "fuck";

  # --- Shell Initialization -------------------------------
  environment.variables.ZDOTDIR = "$HOME/.config/zsh";

  # --- Shell: All -----------
  environment.shellInit = ''
  '';

  # --- Shell: Interactive ---
  environment.interactiveShellInit = ''
  '';

  # --- Shell: Login ---------
  environment.loginShellInit = ''
    # Show system info on login
    [ -x "$(command -v neofetch)" ] && neofetch
  '';
}
