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
  environment = {
    variables.ZDOTDIR = "$HOME/.config/zsh";  # TODO: Use sessionVariables?

    # --- Shell: All -----------
    #shellInit = ''
    #'';

    # --- Shell: Interactive ---
    #interactiveShellInit = ''
    #'';

    # --- Shell: Login ---------
    # TODO: Only perform for first login
    #loginShellInit = ''
    #  # Show system info on login
    #  neofetch
    #'';

    pathsToLink = [ "/share/bash-completion" ];                   # Always link bash completion. Used directly by bash & ZSH compat.
    systemPackages = [ pkgs.unixODBC ];                           # Package to get CLI clients to connect to ODBC databases.
    unixODBCDrivers = with pkgs.unixODBCDrivers; [ sqlite psql ]; # Unix ODBC drivers to register in /etc/odbcinst.ini
  };
}
