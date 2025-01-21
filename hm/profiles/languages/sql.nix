{ config, lib, pkgs, ... }:
{
  home.packages = [
    pkgs.sqlx-cli # SQLx CLI
    pkgs.sqldiff  # Diff .sqlite files
    pkgs.sqlite   # Database engine
    pkgs.sqlint   # Linter
    pkgs.sqldef   # 
    pkgs.sqls     # Language server

    # flatpak install flathub io.github.limads.Queries
    # https://flathub.org/apps/me.ppvan.psequel
  ];
}
