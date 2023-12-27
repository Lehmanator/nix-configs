#(pkgs.nixos [
#  ({ config, lib, pkgs, modulesPath, ... }: {
    imports = [ "${modulesPath}/image/repart.nix" ];

    boot.loader.grub.enable = false;
    fileSystems."/".device = "/dev/disk/by-label/nixos";
    image.repart = let
      inherit (pkgs.stdenv.hostPlatform) efiArch;
    in {
      name = "image";
      seed = "41ba52d5-ef91-4b93-b3cd-053b5c125275"; # Random, but fixed for reproducibility. Run: uuidgen
      split = false; # Enables generation of split artifacts from partitions. If true, for each partition w/ SplitName= set, generates separate output file containing the partition contents.
      #package = pkgs.systemd; # pkgs.systemdMinimal.override {withCryptsetup=true;};
      partitions = {
        "esp" = {
          contents = {
            "/EFI/BOOT/BOOT${lib.toUpper efiArch}.EFI".source =
              "${pkgs.systemd}/lib/systemd/boot/efi/systemd-boot${efiArch}.efi";
            "/loader/entries/nixos.conf".source = pkgs.writeText "nixos.conf" ''
              title NixOS
              linux /EFI/nixos/kernel.efi
              initrd /EFI/nixos/initrd.efi
              options init=${config.system.build.toplevel}/init ${toString config.boot.kernelParams}
            '';
            "/EFI/nixos/kernel.efi".source =
              "${config.boot.kernelPackages.kernel}/${config.system.boot.loader.kernelFile}";
            "/EFI/nixos/initrd.efi".source =
              "${config.system.build.initialRamdisk}/${config.system.boot.loader.initrdFile}";
          };
          repartConfig = {
            Type = "esp";
            Format = "vfat";
            SizeMinBytes = "96M"; #"1024M";
          };
        };
        "store" = {
          storePaths = [ config.system.build.toplevel ];
          stripNixStorePrefix = true;
          repartConfig = {
            # Specify the repart options for a partiton as a structural setting.
            #   Options: <https://www.freedesktop.org/software/systemd/man/repart.d.html>
            # Types follow: https://uapi-group.org/specifications/specs/discoverable_partitions_specification
            Type = "linux-generic";  #  esp | xbootldr
            # | home           | linux-generic         | swap | var | tmp | srv
            # | root           | root-verity           | root-verity-sig
            # | root-secondary | root-secondary-verity | root-secondary-verity-sig
            # | root-{arch}    | root-{arch}-verity    | root-{arch}-verity-sig
            # | usr            | usr-verity            | usr-verity-sig
            # | usr-secondary  | usr-secondary-verity  | usr-secondary-verity-sig
            # | usr-{arch}     | usr-{arch}-verity     | usr-{arch}-verity-sig
            # |
            Label = "nix-store";
            # ...
          };
        };
        "root" = {
          storePaths = [ config.system.build.toplevel ];
          repartConfig = {
            Type = "root";
            Format = "ext4";
            Label = "nixos";
            Minimize = "guess";
          };
        };
      };
    };

#  })
#]).image


