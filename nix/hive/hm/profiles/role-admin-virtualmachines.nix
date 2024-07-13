{ lib, pkgs, ... }: {
  home.packages = [
    pkgs.cockpit
    # pkgs.nur.repos.fedx.cockpit
    # pkgs.nur.repos.fedx.cockpit-machines
    # pkgs.nur.repos.fedx.libvirt-dbus
    pkgs.terraform-providers.libvirt
  ];
}
