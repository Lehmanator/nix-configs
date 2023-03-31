{ config, lib, pkgs, ... }: {
  imports = [];

  gtk.theme.package = pkgs.adw-gtk3;

}
