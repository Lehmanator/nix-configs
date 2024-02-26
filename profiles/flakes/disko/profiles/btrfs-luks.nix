{ inputs, ... }: {
  #imports = [];
  disko.devices.disk.main.content.partitions.luks.content.content = {
    type = "btrfs";
    extraArgs = ["-f"];
    subvolumes = {
      "/nix" = { mountpoint = "/nix"; mountOptions = [ "compress=zstd" "noatime" ]; };
      "/persist" = { mountpoint = "/nix/persist"; mountOptions = [ "compress=zstd" "noatime" "noexec" ]; };
      "/var" = { mountpoint = "/var"; mountOptions = [ "default" ]; };

      # https://git.dblsaiko.net/systems/tree/configurations/invader/swap.nix
      # TODO: Conditional if swap enabled on system.
      "/swap" = { mountpoint = "/nix/swap"; swap.swapfile.size = "32G"; };

      # TODO: Conditional if home in system or separate partition.
      "/home" = { mountpoint = "/home"; mountOptions = [ "compress=zstd" "noatime" ]; };
    };
  };
}
