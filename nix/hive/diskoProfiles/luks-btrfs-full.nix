{ inputs, ... }: {
  disko.devices.disk.main.content.partitions.luks = {
    size = "100%";
    content = {
      type = "luks";
      name = "crypted";
      askPassword = true;
      settings.allowDiscards = true;
      content = {
        type = "btrfs";
        extraArgs = ["-f"];
        subvolumes = {
          "/nix" = { mountpoint = "/nix"; mountOptions = [ "compress=zstd" "noatime" ]; };
          "/persist" = { mountpoint = "/nix/persist"; mountOptions = [ "compress=zstd" "noatime" "noexec" ]; };
          "/home" = { mountpoint = "/home"; mountOptions = [ "compress=zstd" "noatime" ]; };
          # https://git.dblsaiko.net/systems/tree/configurations/invader/swap.nix
          "/swap" = { mountpoint = "/nix/swap"; swap.swapfile.size = "32G"; };
          "/var" = { mountpoint = "/var"; mountOptions = [ "default" ]; };
        };
      };
    };
  };
}
