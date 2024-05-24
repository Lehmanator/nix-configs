{ inputs, ... }: {
  disko.devices = {
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [ "defaults" "size=1G" "mode=755" ];
    };
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1024M";
            type = "EF00";
            content = {
              mountpoint = "/boot";
              mountOptions = [ "defaults" ];
              format = "vfat";
              type = "filesystem";
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              askPassword = true;
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/persist" = {
                    mountpoint = "/nix/persist";
                    mountOptions = [ "compress=zstd" "noatime" "noexec" ];
                  };
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  # https://git.dblsaiko.net/systems/tree/configurations/invader/swap.nix
                  "/swap" = {
                    mountpoint = "/nix/swap";
                    swap.swapfile.size = "2G";
                  };
                  "/var" = {
                    mountpoint = "/var";
                    mountOptions = [ "default" ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
