{ config, lib, pkgs, device ? "/dev/nvme0n1", ... }:
{
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      partitions = {
        esp = {
          type = "EF00";
          label = "esp";
          start = "1MiB";
          end = "512MiB";
          content = {
            type = "filesystem";
            format = "vfat";
            mountOptions = ["umask=0077"];
            mountpoint = "/boot";
          };
        };
        nixos = {
          label = "nixos";
          start = "512MiB";
          end = "100%";
          content = {
            type = "luks";
            name = "nixos";
            content = {
              type = "lvm_pv";
              vg = "nixos";
            };
          };
        };
      };
    };
    lvm_vg.nixos = {
      type = "lvm_vg";
      lvs = {
        root = {
          size = "";
          content = {
            type = "btrfs";
            subvolumes = {
              nix-store.mountpoint = "/nix/store";
              nix.mountpoint = "/nix";
              state.mountpoint = "/nix/state";
              persist.mountpoint = "/nix/persist";
            };
          };
        };
        swap = {
          name = "swap";
          size = "100%FREE";
          content.type = "swap";
        };
      };
    };

    # TODO: tmpfs for root
  };

  fileSystems."/nix/state".neededForBoot = true;
  fileSystems."/nix/persist".neededForBoot = true;
}
