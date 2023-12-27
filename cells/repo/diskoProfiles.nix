{ lib
, main ? true
, nvme ? true
, ssd ? true
, virtual ? false

, tmpfs ? true
, swap ? false
, persist ? false

, ...
}:
let
  getDevice = "/dev/" + (
    if nvme then (if main then "nvme0n1" else "nvme0n2")
    else (if virtual then "vd" else if ssd then "sd" else "hd") + (if main then "a" else "b")
  );

  mkDisk = partitions: disk: {
    device = disk;
    type = "disk";
    content = {
      type = "gpt";
      inherit partitions;
    };
  };

  mkLuks =
  { passfile ? "/tmp/passwd.luks"
  , keyfiles ? [ "/tmp/secret.luks" ]
  , partition ? {}
  , interactive ? true
  , ...
}: {
    size = "100%";
    content = {
      type = "luks";
      name = "crypted";
      extraOpenArgs = [ "--allow-discards" ];
      # if you want to use the key for interactive login be sure there is no trailing newline
      # for example use `echo -n "password" > /tmp/secret.key`
      passwordFile = lib.mkIf interactive passfile; # Interactive
      settings.keyFile = builtins.elemAt keyfiles 0;
      additionalKeyFiles = keyfiles;
      content = partition;
    };
  };

  mkPartitionBoot = size: mountpoint: {
    size = size ? "1024M";
    type = "EF00";
    content = {
      mountpoint = mountpoint ? "/boot";
      type = "filesystem";
      format = "vfat";
      mountOptions = [ "defaults" ];
    };
  };

  mkPartitionBtrfs = { home ? true, boot ? false, ... }: {
    content = {
      type = "btrfs";
      extraArgs = ["-f"];
      subvolumes = {
        "/boot" = lib.mkIf boot {
          mountpoint = "/boot";
          mountOptions = ["defaults" "noatime"];
        };

        "/home" = lib.mkIf home {
          mountpoint = "/home";
          mountOptions = [ "compress=zstd" "noatime" ];
        };

        "/nix" = {
          mountpoint = "/nix";
          mountOptions = [ "compress=zstd" "noatime" ];
        };

        "/persist" = lib.mkIf persist {
          mountpoint = "/persist"; #"/nix/persist"
          mountOptions = [ "compress=zstd" "noatime" ];
        };

        "/root" = {
          mountpoint = "/";
          mountOptions = [ "compress=zstd" "noatime" ];
        };

        # TODO: Not implemented yet
        "/swap" = lib.mkIf swap {
          mountpoint = "/swap";
          swap.enable = true;
          swap.files = [{ size = "128G"; }];
        };
      };
    };
  };

in
{
  # Temporary filesystem at root
  tmpfs = { size ? "4G" , mode ? "755" , defaults ? true , ... }: { disko.devices.nodev."/" = {
    fsType = "tmpfs";
    mountOptions = [ "size=${size}" "mode=${mode}" ] ++ lib.optional defaults "defaults";
  };};

  boot = { size ? "1024M" , mountpoint ? "/boot" , ... }: { disko.devices.disk.main.content.partitions.ESP = {
      inherit size;
      type = "EF00";
      content = {
        inherit mountpoint;
        type = "filesystem";
        format = "vfat";
        mountOptions = [ "defaults" ];
      };
    };
  };

  # Encrypted LUKS partition containing BTRFS filesystem
  luksBtrfs = mkDisk getDevice {
    main = true;
    partitions = {
      ESP = mkPartitionBoot;
      luks = mkLuks mkPartitionBtrfs;
    };
  };
}
