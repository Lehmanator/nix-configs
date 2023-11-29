{ inputs, ... }: {
  disko.devices = {
    nodev."/" = { fsType = "tmpfs"; mountOptions = [ "defaults" "size=3G" "mode=755" ]; };
    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions.ESP = {
          size = "1024M";
          type = "EF00";
          content = { mountpoint = "/boot"; mountOptions = [ "defaults" ]; format = "vfat"; type = "filesystem"; };
        };
        partitions.luks = {
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
                "/nix" = { mountpoint = "/nix"; mountOptions = [ "compress=zstd" "noatime" ]; };
                "/persist" = { mountpoint = "/nix/persist"; mountOptions = [ "compress=zstd" "noatime" "noexec" ]; };
                "/home" = { mountpoint = "/home"; mountOptions = [ "compress=zstd" "noatime" ]; };
                "/swap" = { mountpoint = "/swap"; swap.swapfile.size = "24G"; };
                "/var" = { mountpoint = "/var"; mountOptions = [ "default" ]; };
              };
            };
          };
        };
      };
    };
  };
}
