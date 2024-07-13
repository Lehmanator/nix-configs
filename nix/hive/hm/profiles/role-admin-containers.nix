{ config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.cockpit
    # pkgs.nur.repos.fedx.cockpit
    # pkgs.nur.repos.fedx.cockpit-podman
    pkgs.pods
    pkgs.nur.repos.wolfangaukang.clair-scanner # Scan containers for vulns
  ];
}
