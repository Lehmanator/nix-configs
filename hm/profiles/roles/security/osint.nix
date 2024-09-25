{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.nur.repos.exploitoverload.maltego  # OSINT & forensic application
    pkgs.instaloader  # 
    pkgs.sherlock     # Hunt down social accounts by username across services    
    pkgs.socialscan   # 
    pkgs.snscrape     # 
  ];
}
