{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.fedx.cockpit
    pkgs.nur.repos.fedx.cockpit-machines
    pkgs.nur.repos.fedx.cockpit-podman
    pkgs.nur.repos.fedx.libvirt-dbus
  ];

}
