{
  inputs,
  config,
  self,
  ...
}: let
  inherit (inputs.haumea.lib) load loaders matchers transformers;
in {
  # Disko: systems=["aarch64-linux" "i686-linux" "riscv64-linux" "x86_64-linux"];
  perSystem = {
    config,
    lib,
    pkgs,
    system,
    ...
  }: let
    inherit
      (inputs.disko.lib)
      makeDiskImages
      makeDiskImagesScript
      create
      mount
      ;
    inherit (inputs.disko.packages.${system}) disko disko-doc;
  in {
    packages = {
      # Make disko CLI & documentation available in flake outputs.
      inherit disko disko-doc;

      # Script to create new diskoConfiguration from existing / profiles.

      # Packages to build disk images for nixosConfigurations
      # TODO: Map diskoConfigurations.* to makeDiskImages

      # Packages to write scripts to build disk images for nixosConfigurations
      # TODO: Map diskoConfigurations.* to makeDiskImagesScript
    };

    # Extend NixOS devshell with config from disko devshell.
    #devshells.nixos = lib.recursiveMerge config.devshells.nixos config.devshells.disko;

    devshells.disko = {
      packages = [disko-doc];
      env = [
        {
          name = "BROWSER";
          value = "firefox";
        }
      ]; # TODO: Remove
      commands = [
        {
          name = "disko-docs";
          category = "disko-info";
          help = "Display disko documentation";
          command = "$BROWSER ${disko-doc}/index.html";
        }
        {
          name = "disko-help";
          category = "disko-info";
          help = "Show helptext for disko command";
          command = "${disko}/bin/disko --help";
        }
        {
          name = "disko";
          category = "disko";
          help = "Unmount & destroy all filesystems on the disks we want to format, then run the create & mount mode";
          command = "${disko}/bin/disko --mode disko --flake";
        }
        {
          name = "disko-format";
          category = "disko";
          help = "Create partition tables, zpools, LVMs, RAIDs, & filesystems.";
          command = "${disko}/bin/disko --mode format --flake";
        }
        {
          name = "disko-mount";
          category = "disko";
          help = "Mount the partition at the specified root-mountpoint";
          command = "${disko}/bin/disko --mode mount --flake";
        }

        #  { # Build disk image for current system.
        #    name = "makeDiskImage";
        #    category = "disko";
        #    help = "Build your NixOS disk image";
        #    command = "${config.lib.makeDiskImages} ${config.diskoConfigurations.$(hostname)}";
        #  }
        # TODO: Open nix-community/disko
        # TODO: List diskoConfigurations
        # TODO: List diskoProfiles
        # TODO: List /dev/{nvme0n,sd,vd}*
        # TODO: List /dev/disks/by-*/*
        # TODO: Init template from examples
        # TODO: Init template from existing config/profile
      ];
    };
  };

  flake = {
    lib.disko = {inherit (inputs.disko) lib;};

    # Flake output for partial disk configurations.
    #   NOTE: Requires data from nixosConfigurations.<host> to fully evaluate.
    # TODO: Custom transformer using lib.evalModules
    diskoProfiles = load {
      src = ./profiles;
      inputs = {
        inherit inputs;
        lib = inputs.nixpkgs.lib; # pkgs;
      };
    };

    # Flake output for complete disk configurations
    #   NOTE: Should be finalized disk configs that fully evaluate.
    diskoConfigurations = load {
      src = ./configurations;
      #transformer = ; # TODO: Use lib.evalModules to
      inputs = {
        inherit inputs;
        lib = inputs.nixpkgs.lib; # pkgs;
      };
    };

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
  };
}
