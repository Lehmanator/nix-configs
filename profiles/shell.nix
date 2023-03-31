## Shell-agnostic configuration
##
##
{
  self,
  inputs,
  system,
  userPrimary, host,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    ./shell-alias.nix
  ];

  # TODO: Find nix-related program from old config that was better
  programs.command-not-found.enable = true;
  programs.thefuck.enable = true;
  programs.thefuck.alias = true;

  # --- Shell Initialization -------------------------------

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
