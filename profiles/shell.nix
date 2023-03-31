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
  # - nix-index
  programs.command-not-found.enable = false;
  programs.thefuck.enable = true;
  programs.thefuck.alias = "fuck";

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
