{ config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.sherlock                           # Hunt down social media accounts by username across social services
    pkgs.nur.repos.exploitoverload.maltego  # OSINT & forensic application
  ];
}
