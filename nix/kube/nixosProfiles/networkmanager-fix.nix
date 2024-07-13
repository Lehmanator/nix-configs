{config, lib, pkgs, ...}: {
  # https://docs.rke2.io/known_issues#networkmanager
  networking.networkmanager.unmanaged = [
    "interface-name:cali*"
    "interface-name:flannel*"
  ];
}
