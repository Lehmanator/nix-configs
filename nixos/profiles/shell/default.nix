{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./fish.nix
    ./zsh.nix
  ];
  environment = {
    # Link bash completions. Used by bash & ZSH compat.
    pathsToLink = ["/share/bash-completion"];

    # Package to get CLI clients to connect to ODBC databases.
    systemPackages = [pkgs.bash pkgs.zsh pkgs.nushell pkgs.unixODBC];

    # Unix ODBC drivers to register in /etc/odbcinst.ini
    unixODBCDrivers = [pkgs.unixODBCDrivers.sqlite pkgs.unixODBCDrivers.psql];

    shellAliases.ctl = "systemctl";
    shells = [pkgs.bash pkgs.zsh pkgs.nushell];
  };

  # --- command-not-found ---
  # TODO: Find nix-related program from old config that was better
  # - manix, comma ?
  programs.command-not-found.enable = lib.mkDefault false;
}
