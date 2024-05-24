{ self, inputs, cell, }:
let
  system = "aarch64-linux";
  profiles = {
    cell = with cell.nixosProfiles; [
      apparmor
      cachix-agent
      desktop
      display-base
      gnome
      hercules-ci
      homed
      locale-est
      peripherals-apple
      peripherals-logitech
      tailscale-mullvad-exit-node
      tpm2
      #homed sops user-primary peripherals-printers peripherals-scanners server-k3s-node-main ssbm-nix
      # fprintd #../..profiles/common/editor # DISABLED
      #../../profiles/(nixos nixos/boot.nix nixos/security.nix nixos/virt.nix)
    ];
    cells = with inputs.cells; [ ];
    omnibus = [ ];
  };
  modules = {
    cell = with cell.nixosModules; [ debug ];
    cells = with inputs.cells;
      [
        #android.nixosModules.attestation-server
      ];
    omnibus = with inputs.omnibus.flake.inputs; [
      #agenix.nixosModules.age
      arion.nixosModules.arion
      disko.nixosModules.default
      microvm.nixosModules.host
      nixos-hardware.nixosModules.framework-12th-gen-intel
      ragenix.nixosModules.age
      #snapshotter.nixosModules.default #containerd k3s nix-snapshotter preload-containerd (all have -rootless versions)
      sops-nix.nixosModules.sops
      #srvos.nixosModules.desktop
      #srvos.nixosModules.server
      #srvos.nixosModules.mixins-nginx
      #srvos.nixosModules.mixins-nix-experimental
      #srvos.nixosModules.mixins-systemd-boot
      #srvos.nixosModules.mixins-telegraf
      #srvos.nixosModules.mixins-terminfo
      #srvos.nixosModules.mixins-tracing
      #srvos.nixosModules.mixins-trusted-nix-caches
      ##srvos.nixosModules.roles-github-actions-runner
      #srvos.nixosModules.roles-nix-remote-builder
      #srvos.nixosModules.roles-prometheus
    ];
    inputs = with inputs; [
      { _module.args = { inherit inputs user; }; }
      (import "${inputs.mobile-nixos}/lib/configuration.nix" {
        device = "oneplus-fajita";
      })
      (inputs.self + /hosts/fajita)
      inputs.nixpkgs-gnome-mobile.nixosModules.gnome-mobile
    ];
    nixpkgs =
      [ (inputs.nixpkgs + /nixos/modules/installer/scan/not-detected.nix) ];
  };
in
{
  inherit system;
  specialArgs = {
    inherit inputs cell self;
    user = "sam";
  };
  colmena = {
    nixpkgs = { }; # Is this `nixpkgs.config`?
  };
  colmenaConfiguration = {
    inherit (self.nixosConfiguration) bee imports;
    deployment = {
      allowLocalDeployment = true;
      tags = [ "laptop" ];
      targetHost = "127.0.0.1";
    };
  };
  homeConfiguration = {
    bee = {
      inherit (self) system;
      home = inputs.home-manager;
      pkgs = cell.pkgs.unstable-with-overlays;
    };
    home = {
      stateVersion = "24.05";
      username = "sam";
      homeDirectory = "/home/sam";
    };
  };
  nixosConfiguration = {
    nixpkgs.hostPlatform = system;
    bee = {
      # TODO: import from cell.pkgs.<name>
      pkgs = import inputs.nixpkgs {
        #inherit (self) system;
        inherit system;
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = true;
          android_sdk.accept_license = true;
        };
        overlays = with inputs; [
          # omnibus
          agenix.overlays.default
          arion.overlays.default
          audioNix.overlays.default
          devshell.overlays.default
          fenix.overlays.default
          flake_env.overlays.default
          microvm.overlay
          nil.overlays.coc-nil
          nil.overlays.nil
          nix-filter.overlays.default
          nuenv.overlays.nuenv
          nur.overlay
          ragenix.overlays.default
          snapshotter.overlays.default
          sops-nix.overlays.default
          typst.overlays.default

          # flake.nix
          inputs.nix-vscode-extensions.overlays.default
        ];
      };
      inherit (self) system;
      inherit (inputs.omnibus.flake.inputs) darwin;
      home = inputs.omnibus.flake.inputs.home-manager;
    };
    imports = with inputs;
      [{
        system.stateVersion = "24.05";
        boot = {
          initrd = {
            availableKernelModules =
              [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
          };
          kernelModules = [ "kvm-intel" ];
          loader.efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot/efi";
          };
        };
        console.useXkbConfig = true;
        #environment = {
        #  etc.machine-id.text = "aa38a832d16e436d8aab8bb0550d4810";
        #};
        hardware = {
          cpu.intel.updateMicrocode = lib.mkDefault true;
          enableAllFirmware = true;
          enableRedistributableFirmware = lib.mkDefault true;
          sensor.iio.enable = true;
        };
        networking = {
          #hostName = "fajita";
          useDHCP = lib.mkDefault true;
        };
        nix.settings.extra-trusted-public-keys =
          [ "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs=" ];
        powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
        programs = {
          git = {
            enable = true;
            package = pkgs.gitFull;
          };
          traceroute.enable = true;
        };
        qt.enable = true;
        users.users.sam = {
          isNormalUser = true;
          description = "Sam Lehman";
          extraGroups = [ "wheel" "users" "dialout" ];
        };
      }] ++ profiles.cell ++ profiles.cells ++ profiles.omnibus ++ modules.cell
      ++ modules.cells ++ modules.inputs ++ modules.nixpkgs ++ modules.omnibus;
  };
}
