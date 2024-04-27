{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.wolfangaukang.clair-scanner   # Scan containers for vulns
  ];

}
