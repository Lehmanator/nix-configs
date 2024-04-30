{ inputs, config, lib, pkgs, ... }: {
  imports = [ ];

  home.packages = [
    pkgs.nur.repos.wolfangaukang.clair-scanner # Scan containers for vulns
    pkgs.nur.repos.fedx.cockpit
    pkgs.nur.repos.fedx.cockpit-podman
  ];
}
