{ config
, lib
, pkgs
, user
, ...
}:
{
  imports = [
    #./nushell.nix
    ./zsh.nix
  ];

  environment = {
    #sessionVariables.ZDOTDIR = "$HOME/.config/zsh";  # TODO: Use sessionVariables?
    pathsToLink = [ "/share/bash-completion" ]; #                 # Link bash completions. Used by bash & ZSH compat.
    systemPackages = [ pkgs.unixODBC ]; #                         # Package to get CLI clients to connect to ODBC databases.
    unixODBCDrivers = with pkgs.unixODBCDrivers; [ sqlite psql ]; # Unix ODBC drivers to register in /etc/odbcinst.ini

    # --- Shell Initialization ---
    #interactiveShellInit = "";
    #loginShellInit = "neofetch";
    #shellInit = "";

    # --- Shell Aliases ---
    shellAliases.ctl = "systemctl";
  };

  # --- Prompt -------------------------------------------------------
  #programs.starship = { # Prompt for Bash & ZSH
  #  enable = true;
  #  interactiveOnly = false;  # Some plugins require this to be set to false to function correctly. Default=true
  #  #settings = {};
  #};

  # --- Shell Utils ----------------------------------------
  # --- command-not-found ---
  # TODO: Find nix-related program from old config that was better
  # - manix ?
  programs.command-not-found.enable = lib.mkDefault false;

  # --- thefuck: command corrector ---
  #programs.thefuck = {
  #  enable = true;
  #  alias = "fuck";
  #};
}
