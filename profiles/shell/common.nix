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

  # --- Shell Utils ----------------------------------------

  # --- fzf: fuzzy searcher ---
  programs.fzf = {
    fuzzyCompletion = true;  # Enables completion widgets for bash & zsh
    keybindings = true;      # Enables shell keybindings to complete with fzf widgets
  };

  # --- command-not-found ---
  # TODO: Find nix-related program from old config that was better
  # - nix-index ?
  # - manix ?
  programs.command-not-found.enable = false;

  # --- thefuck: command corrector ---
  programs.thefuck = {
    enable = true;
    alias = "fuck";
  };

}
