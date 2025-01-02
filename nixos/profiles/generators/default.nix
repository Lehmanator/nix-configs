{ inputs, config, lib, pkgs, ... }:
{
  #
  # https://github.com/nix-community/nixos-generators
  #
  # $ nix build .#nixosConfigurations.<host>.config.formats.<format>
  # $ nix run github:nix-community/nixos-generators#app
  #
  # nixos-generators.nixosModules: all-formats,
  #        Cloud: amazon, azure, cloudstack, do, gce, linode,
  #   Containers: docker, lxc, lxc-metadata,
  #        Kexec: kexec, kexec-bundle,
  #   Kubernetes: kubevirt, openstack, 
  #         ISOs: iso, install-iso, install-iso-hyperv,
  #  Hypervisors: hyperv, proxmox, proxmox-lxc,
  #          VMs: qcow, qcow-efi, virtualbox, vagrant-virtualbox, vm, vm-bootloader, vm-nogui, vmware
  #          Raw: raw, raw-efi,
  #     SD Cards: sd-aarch64, sd-aarch64-installer, sd-x86_64,
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
  ];
  formatConfigs = {
    # iso = {};
  };
}
