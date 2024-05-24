{ inputs, cell, self, }@args:
#builtins.trace (builtins.mapAttrs (n: v: "${n} = ${v.system or "unknown"}") cell.pkgs)
rec {
  colmena = { nixpkgs = { }; };
  colmenaConfiguration = {
    inherit (self.nixosConfiguration) bee imports;
    deployment = {
      allowLocalDeployment = true;
      targetHost = "127.0.0.1";
      tags = [ "minimal" "test" ];
    };
  };
  homeConfiguration = {
    inherit (self.nixosConfiguration) bee;
    home = {
      inherit (self.nixosConfiguration.system) stateVersion;
      username = "sam";
      homeDirectory = "/home/sam";
    };
    imports = [ inputs.omnibus.flake.inputs.sops-nix.homeManagerModule ];
  };
  nixosConfiguration = {
    system.stateVersion = "24.05";
    bee = rec {
      inherit (inputs.omnibus.flake.inputs) darwin;
      inherit (inputs) wsl;
      system = "x86_64-linux";
      home = inputs.omnibus.flake.inputs.home-manager;
      pkgs = inputs.nixpkgs;
      #pkgs = cell.pkgs.${system}.unstable;
    };
    nixpkgs.overlays = [ inputs.ssbm-nix.overlays.default ];
    imports = [
      { _module = { args = { user = "sam"; }; }; }
      inputs.omnibus.flake.inputs.disko.nixosModules.default
      inputs.omnibus.flake.inputs.sops-nix.nixosModules.default
      inputs.omnibus.flake.inputs.srvos.nixosModules.desktop
      inputs.omnibus.flake.inputs.srvos.nixosModules.mixins-mdns # nginx telegraf roles-nix-remote-builder
      inputs.omnibus.flake.inputs.srvos.nixosModules.mixins-nix-experimental
      inputs.omnibus.flake.inputs.srvos.nixosModules.mixins-systemd-boot
      inputs.omnibus.flake.inputs.srvos.nixosModules.mixins-terminfo
      inputs.omnibus.flake.inputs.srvos.nixosModules.mixins-trusted-nix-caches
      inputs.omnibus.flake.inputs.home-manager.nixosModules.home-manager
      inputs.netinstaller.nixosModules.netinstaller
      inputs.omnibus.flake.inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
      inputs.omnibus.flake.inputs.agenix.nixosModules.default
      inputs.omnibus.flake.inputs.arion.nixosModules.arion
      inputs.omnibus.flake.inputs.impermanence.nixosModules.impermanence
      inputs.omnibus.flake.inputs.nur.nixosModules.nur
      #inputs.omnibus.flake.inputs.ragenix.nixosModules.default
      inputs.omnibus.flake.inputs.snapshotter.nixosModules.default
      inputs.declarative-flatpak.nixosModules.default
      inputs.envfs.nixosModules.envfs
      inputs.flake-utils-plus.nixosModules.autoGenFromInputs
      inputs.harmonia.nixosModules.harmonia
      #inputs.hercules-ci.nixosModules.agent-profile #multi-agent-service agent-service
      #inputs.icicle.nixosModules.icicle
      #inputs.kubenix.nixosModules.kubenix.base #docker helm istio k8s submodule submodules test testing
      inputs.lanzaboote.nixosModules.lanzaboote
      inputs.lanzaboote.nixosModules.uki
      inputs.microvm.nixosModules.host
      inputs.microvm.nixosModules.microvm # microvm-options
      inputs.nix-data.nixosModules.nix-data
      #inputs.nixified-ai.nixosModules.invokeai #-{amd,nvidia}
      #inputs.nixified-ai.nixosModules.textgen #-{amd,nvidia}
      inputs.nixos-generators.nixosModules.all-formats
      inputs.nixos-images.nixosModules.noninteractive # kexec-installer #netboot-installer
      inputs.nixvim.nixosModules.nixvim
      #inputs.quick-nix-registry.nixosModules.local-registry
      #inputs.ragenix.nixosModules.ragenix
      inputs.robotnix.nixosModules.attestation-server
      inputs.scalpel.nixosModules.scalpel
      #inputs.ssbm-nix.nixosModules.default
      #inputs.stylix.nixosModules.stylix
    ];
    disko.devices = {
      nodev."/" = {
        fsType = "tmpfs";
        mountOptions = [ "defaults" "size=8G" "mode=755" ];
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
              #  size = "100%";
              #  content = {
              #    type = "luks";
              #    name = "crypted";
              #    askPassword = true;
              #    settings.allowDiscards = true;
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
                    swap.swapfile.size = "32G";
                  };
                  "/var" = {
                    mountpoint = "/var";
                    mountOptions = [ "default" ];
                  };
                };
              };
              #};
            };
          };
        };
      };
    };
    hardware.pulseaudio.enable = false;
    programs.dconf.enable = true;
    services = {
      flatpak.enable = true;
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };
    xdg.portal.enable = true;
    users.groups.sam = { gid = 1000; };
    users.users.sam = {
      initialPassword = "nixos";
      isNormalUser = true;
      uid = 1000;
      group = "sam";
      description = "Sam Lehman";
    };
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      sharedModules = [
        ({ config, lib, ... }: {
          home.homeDirectory = lib.mkForce "/home/${config.home.username}";
        })
        inputs.omnibus.flake.inputs.sops-nix.homeManagerModule
        inputs.omnibus.flake.inputs.impermanence.nixosModules.home-manager.impermanence
        inputs.agenix.homeManagerModules.default
        inputs.ags.homeManagerModules.default
        inputs.anyrun.homeManagerModules.default
        inputs.declarative-flatpak.homeManagerModules.default
        inputs.nixvim.homeManagerModules.nixvim
        #inputs.ragenix.homeManagerModules.default
        #inputs.ssbm-nix.homeManagerModules.default
        #inputs.stylix.homeManagerModules.stylix
        inputs.emanote.homeManagerModule
        inputs.arkenfox.hmModules.default
        inputs.nix-index.hmModules.nix-index
        inputs.nixpkgs-android.hmModules.android
        inputs.nur.hmModules.nur
      ];
      users.sam = { config, lib, pkgs, ... }:
        builtins.removeAttrs homeConfiguration [ "bee" "imports" ];
    };
  };
}
