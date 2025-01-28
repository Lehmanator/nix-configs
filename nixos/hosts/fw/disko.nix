{
  config,
  lib,
  pkgs,
  device ? "/dev/nvme0n1",
  ...
}: {
  disko.memSize = 64 * 1024;
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      imageName = "nixos-fw-btrfs-tmpfs";
      imageSize = "16G";
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
            name = "nixos"; # device-mapper name when decrypted
            extraOpenArgs = {};
            # NOTE: Secret must be on disk at partition time.
            #  sops-nix relies on activationScripts to decrypt secrets to /run/secrets
            #  which will not be activated in the installation image.
            #  We must find some other mechanism to decrypt the secrets or activate the
            #  configuration before partitioning.
            # passwordFile = "/tmp/secret.key";
            passwordFile = config.sops.secrets.luks-password-system.path;
            additionalKeyFiles = [
              config.sops.secrets.luks-password-system.path
              "/tmp/additionalSecret.key"
            ];

            settings = {
              # if you want to use the key for interactive login be sure there is no trailing newline
              # example:  `echo -n "password" > /tmp/secret.key`
              # keyFile = "/tmp/secret.key";
              keyFile = config.sops.secrets.luks-password-system.path;
              allowDiscards = true;
            };

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
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = ["-f"]; # Override existing partition
            subvolumes = {
              home = {
                mountOptions = ["compress=zstd"];
                mountpoint = "/home";
              };
              # nix-store.mountpoint = "/nix/store";
              nix = {
                mountpoint = "/nix";
                mountOptions = ["compress=zstd" "noatime"];
              };
              state = {
                mountpoint = "/nix/state";
                mountOptions = ["compress=zstd" "noatime"];
              };
              persist = {
                mountpoint = "/nix/persist";
                mountOptions = ["compress=zstd" "noatime"];
              };
              swap = {
                mountpoint = "/.swapvol";
                swap.swapfile.size = "128G";
              };
            };
          };
        };
        # swap = {
        #   name = "swap";
        #   size = "100%FREE";
        #   content.type = "swap";
        # };
      };
    };

    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = ["size=8G" "defaults" "mode=755"];
    };
  };

  fileSystems."/nix/state".neededForBoot = true;
  fileSystems."/nix/persist".neededForBoot = true;

  # https://github.com/nix-community/disko/blob/master/docs/disko-install.md#example-for-a-nixos-installer
  # https://github.com/nix-community/disko/blob/master/docs/interactive-vm.md
  virtualisation.vmVariantWithDisko = {
    virtualisation.fileSystems."/nix/persist".neededForBoot = true;
  };
}
