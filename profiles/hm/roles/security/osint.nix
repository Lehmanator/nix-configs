{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.exploitoverload.maltego  # OSINT & forensic application
    pkgs.nur.repos.wolfangaukang.sherlock   # Hunt down social media accounts by username across social services
  ];

}
