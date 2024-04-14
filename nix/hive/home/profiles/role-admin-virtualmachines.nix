{ inputs, config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.nur.repos.fedx.cockpit
    pkgs.nur.repos.fedx.cockpit-machines
    pkgs.nur.repos.fedx.libvirt-dbus
  ];
}
