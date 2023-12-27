{ disks    ? ["/dev/vda"]
, keyfiles ? ["/tmp/secret.luks"] # TODO: Match to agenix/sops-nix secret
, passfile ?  "/tmp/passwd.luks"
, tmpfs    ? true
, swap     ? false
, persist  ? false
, ...
}:
{
  disko.devices = {
    disk.main = {
      type = "disk";
      device = builtins.elemAt disks 0;
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1024M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
              ];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              extraOpenArgs = [ "--allow-discards" ];
              # if you want to use the key for interactive login be sure there is no trailing newline
              # for example use `echo -n "password" > /tmp/secret.key`
              passwordFile = passfile; # Interactive
              settings.keyFile = builtins.elemAt keyfiles 0;
              additionalKeyFiles = keyfiles;
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                # TODO: Conditional subvolumes based on args
                subvolumes = {
                  "/home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "/root" = {
                    mountpoint = "/";
                    mountOptions = [ "compress=zstd" "noatime" ];
                  };
                  # TODO: Not implemented yet
                  "/swap" = {
                    mountpoint = "/swap";
                    swap.enable = true;
                    swap.files = [{ size="128G"; }];
                  };
                };
              };
            };
          };
        };
      };
    };
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = ["size=4G" "defaults" "mode=755"];
    };
  };
}
