{ inputs, self
, config, lib, pkgs
, disks      ? ["/dev/nvme0n1"]
, tmpfs      ? true
, tmpfs-home ? false              # Use two switches: one for root, one for home?
, secretMgr  ? "agenix"
, secretDir  ? "/run/secrets"
, ...
}:
#
# Disk layout:
#
# - LUKS2-encrypted root filesystem
# - BTRFS subvolumes for sub-partitioning
# - tmpfs ephemeral root filesystem
#
# Notes:
#
# - This file is formatted so you can pass a disk device when you import this file.
# - Default disk is first NVMe drive
#
{

  imports = [
    inputs.disko.nixosModules.default
  ] ++ lib.optionals tmpfs [ inputs.impermanence.nixosModules.default ];

  disko.devices = {
    disk = lib.genAttrs disks (dev: {
      name = lib.replaceStrings ["/"] ["_"] dev;
      type = "disk";
      device = dev; #"/dev/nvme0n1";
      content = {
        type = "gpt";
        partitions = {

          # Boot partition / ESP
          ESP = {
            label = "EFI";
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["defaults"];
            };
          };

          # Main system container
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "encrypted-nixos";
              extraOpenArgs = ["--allow-discards"];

              # TODO: Convert keyFiles & passwordFile to agenix / sops-nix secrets
              # if you want to use the key for interactive login be sure there is no trailing newline
              # for example use `echo -n "password" > /tmp/secret.key`
              #passwordFile = "/run/secrets/luks/root.passwd";       #"/tmp/secret.key"; # Interactive
              settings.keyFile = "/run/secrets/luks/root.lukskey";   #"/tmp/secret.key";
              additionalKeyFiles = [
                "/run/secrets/luks/root-extra.lukskey"
                #"/tmp/additionalSecret.key"
              ];

              # TODO: Need to create persistence directory for impermanence? Under /nix?
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = if tmpfs then {  # tmpfs=true => tmpfs root, no root btrfs subvolume + need /var btrfs subvolume
                  "/home" = { mountpoint = "/home"; mountOptions = ["compress=zstd" "noatime"]; };
                  "/nix"  = { mountpoint = "/nix";  mountOptions = ["compress=zstd" "noatime"]; };
                  "/var"  = { mountpoint = "/var";  mountOptions = ["compress=zstd" "noatime"]; }; # Only necessary with tmpfs / rootfs
                } else {
                  "/home" = { mountpoint = "/home"; mountOptions = ["compress=zstd" "noatime"]; };
                  "/nix"  = { mountpoint = "/nix";  mountOptions = ["compress=zstd" "noatime"]; };
                  "/root" = { mountpoint = "/";     mountOptions = ["compress=zstd" "noatime"]; };
                };
              };
            };
          };

        };
      };
    });

  # TODO: Enable impermanence
    # Add a regular tmpfs dir mounted at /tmp
    nodev = if tmpfs then { "/"    = { fsType = "tmpfs"; mountOptions = ["size=2G" "defaults" "mode=755"]; }; }
                     else { "/tmp" = { fsType = "tmpfs"; mountOptions = ["size=1G"                      ]; }; };

  };

  # TODO: Create secrets for LUKS2 keyFiles & passwordFile with either agenix and/or sops-nix

  # TODO: Any additional setup for systemd-homed per-user encrypted home directories?

}
