{ inputs, config, self, ... }:
{
  # Disko: systems=["aarch64-linux" "i686-linux" "riscv64-linux" "x86_64-linux"];
  #perSystem = { config, lib, pkgs, system, ... }:
  #  let
  #    #inherit (inputs.disko.lib) makeDiskImages makeDiskImagesScript create mount;
  #    inherit (inputs.disko.packages.${system}) disko disko-doc;
  #  in
  #  {
  #    packages = {
  #      inherit disko
  #        disko-doc; # Make disko CLI & documentation available in flake outputs.
  #      # Script to create new diskoConfiguration from existing / profiles.
  #      # Packages to build disk images for nixosConfigurations
  #      # TODO: Map diskoConfigurations.* to makeDiskImages
  #      # Packages to write scripts to build disk images for nixosConfigurations
  #      # TODO: Map diskoConfigurations.* to makeDiskImagesScript
  #    };
  #
  #    # Extend NixOS devshell with config from disko devshell.
  #    #devshells.nixos = lib.recursiveMerge config.devshells.nixos config.devshells.disko;
  #  };

  #flake = {
  #lib.disko = { inherit (inputs.disko) lib; };
  # NixOS module to specify data related to disk configuration.
  # - Disk Paths:
  #   - /dev/disk/by-{diskseq, id, partuuid, path, uuid}
  #   - /dev/nvme0n<num>
  #   - /dev/{sd,vd}<letter>
  # - Tmpfs Options: isTmpfsRoot, isTmpfsHome,
  # - Swap Options: hasSwap, hasSwapPartition, hasSwapFile
  # TODO: Override/extend original disko nixosModule?
  #nixosModules = {
  #  disks = ({config, lib, pkgs, ...}: let cfg = config.disks; in {
  #    imports = [../../modules/disko];
  #    options.disks = {};
  #    config = lib.mkIf config.disko.enable {
  #      disks = { system = { }; home = { }; };
  #      tmpfs = lib.mkOption {
  #        type = lib.types.bool;
  #        default = false;
  #        description = "Whether disk should use a tmpfs root";
  #        example = true;
  #      };
  #    };
  #  };
  #};

  # NixOS profiles that configure NixOS to use disko
  # NixOS profiles to optionally use some disko layout
  #nixosProfiles.disko = with inputs.self.packages; {
  #base = {
  #  config,
  #  lib,
  #  pkgs,
  #  ...
  #}:
  #  with config.networking; let
  #    inherit (inputs.self.packages.${pkgs.system}) disko disko-doc;
  #  in {
  #    # TODO: Import diskoConfigurations.${hostName} only if it exists
  #    imports = [inputs.disko.nixosModules.disko];
  #    disko =
  #      (inputs.self.diskoConfigurations.${hostName} {
  #        inherit inputs config lib pkgs;
  #      })
  #      // {
  #        enableConfig = lib.mkDefault true;
  #      };
  #    environment.systemPackages = [disko disko-doc];
  #    services.nginx.virtualHosts = let
  #      locations = {"/disko".root = "${disko}/index.html";};
  #    in {
  #      # Add disko-doc to webserver
  #      localhost = {inherit locations;};
  #      "nixos-docs.${fqdn}" = lib.mkIf (domain != "" && domain != null) {
  #        inherit locations;
  #      };
  #    };
  #  };

  # Profile to run only in installer
  #installer = {
  #  config,
  #  lib,
  #  pkgs,
  #  ...
  #}: {
  #  imports = [config.nixosProfiles.disko-base];
  #  disko.enableConfig = lib.mkImageMediaOverride false;
  #};

  #tmpfs-root = {
  #  config,
  #  lib,
  #  pkgs,
  #  ...
  #}: {
  #  imports = [
  #    config.flake.nixosProfiles.disko-base
  #    config.flake.diskoProfiles.tmpfs-root
  #    inputs.impermanence.nixosModules.impermanence
  #  ];
  #};
  #};
  #};
}
