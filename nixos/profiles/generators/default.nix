{ inputs, config, lib, pkgs, ... }:
{
  # --- NixOS Generators ---
  # https://github.com/nix-community/nixos-generators
  # https://github.com/nix-community/nixos-images
  #
  # $ nix build .#nixosConfigurations.<host>.config.formats.<format>
  # $ nix run github:nix-community/nixos-generators#app
  #
  imports = [
    inputs.nixos-generators.nixosModules.all-formats
    
    # TODO: Integrate nixos-generators & nixos-images
    # TODO: Integrate nixos-generators & microvm.nix
    # TODO: Create custom `formatConfigs` for these
    # WARN: Probably cant use all of these at once
    # WARN: Probably cant use in live system
    # inputs.nixos-images.nixosModules.kexec-installer
    # inputs.nixos-images.nixosModules.netboot-installer
    # inputs.nixos-images.nixosModules.noninteractive
  ];
  
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
  formatConfigs = {
    # iso = {};
  };
}
