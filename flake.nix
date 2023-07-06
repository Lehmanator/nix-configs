{
  nixConfig = {
    connect-timeout = 10;
    #substituters = [
    #  "https://cache.nixos.org"
    #  "https://nixpkgs-wayland.cachix.org"
    #];
    #trusted-keys = [
    #  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    #  "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    #];
  };

  #
  # More Flakes:
  #
  # - https://github.com/NixOS/nixos-search/blob/main/flakes/manual.toml
  #
  inputs =
    #let
    #  fnp = flakeInput: flakeInput // { inputs.nixpkgs.follows = "nixpkgs"; };
    #  ffu = flakeInput: flakeInput // { inputs.flake-utils.follows = "flake-utils"; };
    #  fu = flakeInput: flakeInput // { inputs.utils.follows = "flake-utils"; };
    #  no-flake = flakeInput: flakeInput // { flake = false; };
    #in
    {
      # --- Main -----------------------------------------------------
      nixpkgs = {
        url = "github:NixOS/nixpkgs/nixos-unstable";
      };

      # --- System Types ---------------------------------------------
      nixos = {
        url = "github:NixOS/nixpkgs/nixos-unstable";
      };

      home = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      # Extra home-manager modules:
      # - console.{fish,less,nano,program-variables}
      # - desktop.{gnome,fonts}
      # - languages.{haskell,python,rust}
      home-extra-xhmm = {
        url = "github:schuelermine/xhmm";
      };

      darwin = {
        url = "github:LnL7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # system-manager: NixOS-like configuration of non-NixOS systems
      # -      packages: system-manager.${system}.{default,system-manager}
      # -     devShells: system-manager.${system}.default
      # -          libs: system-manager.lib.?
      # - systemConfigs: system-manager.systemConfigs.?
      system-manager = {
        url = "github:numtide/system-manager";
        #inputs.nixpkgs.follows = "nixpkgs";
        inputs.flake-utils.follows = "flake-utils";
      };

      # nix-on-droid: Termux environment, but using Nix
      # - see_also:
      #   - https://github.com/t184256/nix-on-droid-app
      #   - https://github.com/t184256/nix-compile-for-android
      #   - https://github.com/t184256/droidctl
      # - templates: nix-on-droid.templates.{default,advanced,home-manager,minimal}
      # -  packages: nix-on-droid.packages.${system}.{bootstrap,bootstrapZip,fakedroid,manPages,manualHtml,nix-on-droid,optionsJson,prootTermux,prootTermuxTest,tallocStatic}
      # -  overlays: nix-on-droid.overlays.default
      # -      libs: nix-on-droid.lib.?
      nix-on-droid = {
        url = "github:t184256/nix-on-droid";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # srvos: Server configurations
      # - nixosModules:
      #   - srvos.nixosModules.{common,desktop,server}
      #   - srvos.nixosModules.hardware-{amazon,hetzner-{cloud,online-amd,online-intel},vultr-{bare-metal,vm}}
      #   - srvos.nixosModules.mixins-{cloud-init,nginx,systemd-boot,telegraf,terminfo,tracing,trusted-nix-caches}
      #   - srvos.nixosModules.roles-{github-actions-runner,nix-remote-builder}
      # - nixosConfigurations: srvos.nixosConfigurations.examples-<nixosModule>
      # -                libs: srvos.libs.?
      srvos = {
        url = "github:numtide/srvos";
      };

      # nixos-wsl: NixOS on Windows Subsystem for Linux
      #nixos-wsl = {
      #  url = "github:NixOS/nixos-wsl";
      #};

      # --- SnowflakeOS ----------------------------------------------
      snowflake = { url = "github:snowflakelinux/snowflake-modules"; }; # NixOS modules for SnowflakeOS
      snow = { url = "github:snowflakelinux/snow"; }; # CLI package manager w/ flakes support
      nix-data = { url = "github:snowflakelinux/nix-data"; }; # Provides package `nix-data` and module setting its config.

      # --- Image Builders: Nix --------------------------------------

      # nixos-generators: Image builders
      # -  modules: nixos-generators.nixosModules.{amazon,azure,cloudstack,do,docker,gce,hyperv,install-iso,install-iso-hyperv,iso,kexec,kexec-bundle,kubevirt,linode,lxc,lxc-metadata,openstack,proxmox,proxmox-lxc,qcow,raw,raw-efi,sd-aarch64,sd-aarch64-installer,vagrant-virtualbox,virtualbox,vm,vm-bootloader,vm-nogui,vmware}
      # - packages: nixos-generators.${system}.nixos-{generate,generators}
      nixos-generators = {
        url = "github:nix-community/nixos-generators";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # --- Image Builders: Non-Nix ----------------------------------

      # liminix: Build OpenWRT images
      # -     modules: base, busybox, device, hardware, hostname, liminix-config, outputs, s6, users
      # -    overlays: liminix.overlays.default
      # - configTypes: liminix-config
      # -   devShells: liminix.devShells.default - (pkgs: tufted, routeros.routeros, routeros.ros-exec-script, mips-vm, borderVm.build.vm, go-l2tp, min-copy-closure)
      #liminix = {
      #  url = "https://gti.telent.net/dan/liminix";
      #  flake = false;
      #};

      # robotnix: Build Android images using Nix config
      # - nixosModules: robotnix.nixosModules.attestation-server
      # -     packages: robotnix.packages.x86_64-linux.manual
      # -    devShells: robotnix.devShell.x86_64-linux.robotnix-scripts
      # -    templates: robotnix.defaultTemplate - Basic robotnix configuration
      # -         libs: robotnix.lib
      robotnix = {
        url = "github:danielfullmer/robotnix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # --- Extra Package Sets ---------------------------------------
      nixpkgs-gnome-mobile = { url = "github:chuangzhu/nixpkgs-gnome-mobile"; };
      nixpkgs-wayland = { url = "github:nix-community/nixpkgs-wayland"; };
      nixpkgs-terraform-providers = { url = "github:nix-community/nixpkgs-terraform-providers-bin"; inputs.nixpkgs.follows = "nixpkgs"; };
      nixpkgs-android = { url = "github:tadfisher/android-nixpkgs"; };
      nixpkgs-mozilla = { url = "github:mozilla/nixpkgs-mozilla"; };
      flake-firefox-nightly.url = "github:colemickens/flake-firefox-nightly";
      nixGL = { url = "github:guibou/nixGL"; };
      nixified-ai = { url = "github:nixified-ai/flake"; inputs.nixpkgs.follows = "nixpkgs"; };
      nix-stable-diffusion = { url = "github:gbtb/nix-stable-diffusion"; inputs.nixpkgs.follows = "nixpkgs"; };
      nix-vscode-extensions = { url = "github:nix-community/nix-vscode-extensions"; };
      neovim-nightly-overlay = { url = "github:nix-community/neovim-nightly-overlay"; };
      fenix = { url = "github:nix-community/fenix"; inputs.nixpkgs.follows = "nixpkgs"; };
      nur = { url = "github:nix-community/NUR"; }; # Nix User Repositories
      rust-overlay = {
        # rust-overlay: Rust toolchain packages
        url = "github:oxalica/rust-overlay";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.flake-utils.follows = "flake-utils";
      };

      # --- Libs: Organization ---------------------------------------
      std = { url = "github:divnix/std"; };
      hive = { url = "github:divnix/hive"; };
      fractal = { url = "github:divnix/fractal"; inputs.nixpkgs.follows = "nixpkgs"; };
      haumea = { url = "github:nix-community/haumea"; inputs.nixpkgs.follows = "nixpkgs"; };

      # --- Libs: Packaging ------------------------------------------

      # nixpak: Wrap Nix packages with Flatpak sandboxing
      # - libs: nixpak.lib.nixpak
      nixpak = {
        url = "github:nixpak/nixpak";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # --- Libs: Flakes ---------------------------------------------
      flake-utils = { url = "github:numtide/flake-utils"; };
      flake-utils-plus = { url = "github:gytis-ivaskevicius/flake-utils-plus"; };
      flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
      flake-parts = { url = "github:hercules-ci/flake-parts"; };

      # devour-flake: Executable to devour flake and spit out out paths
      flake-devour = {
        url = "github:srid/devour-flake";
        flake = false;
      };

      # check-flake: Adds a #check package for building all checks for the current system
      flake-check = {
        url = "github:srid/check-flake";
      };

      # https://github.com/juspay/cachix-push

      # --- Modules: Flake-parts -------------------------------------

      # flake-root: module for finding your way to the project root directory";
      # - modules: flake-root.flakeModule
      # -    libs: flake-root.projectRootFile
      flake-root = {
        url = "github:srid/flake-root";
      };

      # nixid: Flake-parts module for running Nix expressions in a feedback loop, so you can iterate on them in a text editor rather than in `nix repl`
      # - modules: nixid.flakeModules.nixid
      nixid = {
        url = "github:srid/nixid";
      };

      # mission-control: Flake-parts module for command list banners in devShells
      # - modules: mission-control.flakeModule
      mission-control = {
        url = "github:Platonic-Systems/mission-control";
      };

      # treefmt-nix: Nix code formatters
      # - modules: treefmt-nix.flakeModule
      treefmt-nix = {
        url = "github:numtide/treefmt-nix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # https://github.com/srid/nixos-flake


      # --- Modules: System ------------------------------------------

      # nixos-hardware: NixOS modules to set options needed for various machines & hardware combos
      nixos-hardware = {
        url = "github:NixOS/nixos-hardware";
      };

      # nixos-mobile: NixOS module to configure NixOS for mobile devices
      nixos-mobile = {
        url = "github:vlinkz/mobile-nixos/gnomelatest";
        #url = "github:NixOS/mobile-nixos";
        flake = false;
      };

      # riscv-phone: Firmware for Freedom E310 & ESP32 RISC-V SOCs
      # -  packages: nixos-riscv-phone.packages.${system}.{esp32,fe310}
      # -  overlays: nixos-riscv-phone.overlays.{default,esp32,fe310}
      # - devShells: nixos-riscv-phone.devShells.{default,esp32,fe310}
      nixos-riscv-phone = {
        url = "github:ngi-nix/riscv-phone";
      };

      # --- Modules: Filesystems -------------------------------------

      # disko: Partition storage disks
      # - packages: disko.packages.${system}.{default,disko,disko-doc,linux-bcachefs}
      # -  modules: disko.nixosModules.disko
      # -     libs: disko.lib.?
      disko = {
        url = "github:nix-community/disko";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # impermanence: tmpfs root/home by default w/ declarative persistence
      # - modules: impermanence.nixosModules.{impermanence,home-manager}
      impermanence = {
        url = "github:nix-community/impermanence";
      };

      # envfs: FUSE fs that returns symlinks to executables
      # -  modules: envfs.nixosModules.envfs       - NixOS config to activate envfs
      # - packages: envfs.packages.${system}.envfs - FUSE fs that returns symlinks to executables
      envfs = {
        url = "github:Mic92/envfs";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # --- Modules: Containers --------------------------------------

      nix-helm = {
        url = "github:gytis-ivaskevicius/nix-helm";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      arion = {
        url = "github:hercules-ci/arion";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # --- Modules: Configuration -----------------------------------

      # nixvim: Create Neovim configs using Nix modules
      # -  modules: nixvim.{nixos,homeManager}Modules.nixvim
      # - packages: nixvim.${system}.?
      # -     libs: nixvim.lib.mkNixvim?
      nixvim = {
        url = "github:pta2002/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      arkenfox = {
        url = "github:dwarfmaster/arkenfox-nixos";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # stylix: Module to theme programs based on wallpaper
      # -  modules: stylix.{darwin,nixos,homeManager}Modules.stylix
      # - packages: stylix.${system}.{docs,palette-generator}
      stylix = {
        url = "github:danth/stylix";
      };

      # lanzaboote: Generate bootspec documents to support SecureBoot
      # -   modules: lanzaboote.nixosModules.lanzaboote
      # -  packages: lanzaboote.packages.x86_64-linux.{lzbt,stub,tool}
      # -  overlays: lanzaboote.overlays.default
      # - devShells: lanzaboote.devShells.x86_64-linux.default
      lanzaboote = {
        url = "github:nix-community/lanzaboote";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.flake-utils.follows = "flake-utils";
        #inputs.rust-overlay.follows = "rust-overlay";
      };

      # nixos-flatpak: Declaratively manage flatpaks
      # -   modules: nixos-flatpak.{nixos,hm}Modules.declarative-flatpak
      # - devShells: nixos-flatpak.${system}.default
      nixos-flatpak = {
        url = "github:GermanBread/declarative-flatpak";
        inputs.nixpkgs.follows = "nixpkgs"; #
      };

      # nix-colors: Module to generate colorschemes & convert to various formats
      #nix-colors = {
      #  url = "github:misterio77/nix-colors";
      #};


      # --- Modules: Secrets -----------------------------------------

      agenix = {
        url = "github:ryantm/agenix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      sops-nix = {
        url = "github:Mic92/sops-nix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      scalpel = {
        url = "github:polygon/scalpel";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # systemd-vaultd: Provide systemd services w/ Hashicorp Vault secret access
      # - nixosModules: systemdVaultd, vaultAgent
      # - pkgs: systemd-vaultd
      systemd-vaultd = {
        url = "github:numtide/systemd-vaultd";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      vaultModule = {
        url = "github:DeterminateSystems/nixos-vault-service/main";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # Musnix: Configure real-time audio
      # - modules: musnix.nixosModules.musnix
      musnix = {
        url = "github:musnix/musnix";
      };

      # --- Modules: Servers -----------------------------------------

      # firefly: Firefly-III personal finance server
      # - modules: firefly.nixosModules.firefly-iii
      firefly = {
        url = "github:timhae/firefly";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # nixos-vscode-server: VSCode webserver
      nixos-vscode-server = {
        url = "github:nix-community/nixos-vscode-server";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # nix-serve-ng: Faster drop-in replacement for nix-serve
      nix-serve-ng = {
        url = "github:aristanetworks/nix-serve-ng";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nix-minecraft = {
        url = "github:Misterio77/nix-minecraft";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      mineflake = {
        url = "github:nix-community/mineflake";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # lldap: Module for LLDAP server
      lldap = {
        url = "github:NickCao/lldap";
        inputs = {
          nixpkgs.follows = "nixpkgs";
          flake-utils.follows = "flake-utils";
          #rust-overlay.follows = "rust-overlay";
        };
      };

      # nix-netboot-serve: Serve NixOS configs as Netboot images
      nix-netboot-serve = {
        url = "github:DeterminateSystems/nix-netboot-serve";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # weblate: Translation util webserver
      weblate = {
        url = "github:ngi-nix/weblate";
      };

      # filestash: Web UI to access many types of file servers
      filestash = {
        url = "github:matthewcroughan/filestash-nix";
      };

      # emanote: Web UI structured view of plain-text notes
      emanote = {
        url = "github:srid/emanote";
      };

      # lnbits: Lightning network Web UI
      lnbits = {
        url = "github:lnbits/lnbits-legend";
      };

      # castopod: Podcast host w/ RSS
      castopod = {
        url = "github:ngi-nix/castopod-host";
      };

      # corteza: Low-code web app UI
      corteza = {
        url = "github:ngi-nix/corteza";
      };

      # liberaforms: Libre non-tracking form hosting
      liberaforms = {
        url = "github:ngi-nix/liberaforms-flake";
      };

      # openki: Open course platform web UI
      # - devShells: nixos-openki.devShells
      # -   modules: nixos-openki.nixosModules.openki
      nixos-openki = {
        url = "github:ngi-nix/openki";
      };

      # taler: GNU Taler open payment manager web UI for NixOS
      # - modules: nixos-taler.nixosModules.talerExchange
      nixos-taler = {
        url = "github:ngi-nix/taler";
      };

      # misskey: Decentralized ActivityPub microblogging platform
      # - modules: nixos-misskey.nixosModules.misskey
      nixos-misskey = {
        url = "github:ngi-nix/misskey-d2n";
      };

      # nixos-mailserver: Module for mailserver
      # - nixosModules: mailserver
      nixos-mailserver = {
        url = "gitlab:simple-nixos-mailserver/nixos-mailserver"; #"gitlab:lewo/nixos-mailserver";
      };

      # etherpad:
      # - modules: etherpad.nixosModules.etherpad (commented out)
      etherpad = {
        url = "github:ngi-nix/etherpad_nix";
      };

      # neuropil: Open source cybersecurity mesh
      neuropil = {
        url = "gitlab:pi-lar/neuropil";
      };

      #nixcloud = {
      #  url = "github:nixcloud/nixcloud-webservices";
      #};

      # selfhostblocks: Modules for self-hosting servers with options pre-configured to sensible, secure defaults
      #selfhostblocks = {
      #  url = "github:ibizaman/selfhostblocks";
      #  flake = false;
      #};


      # --- Packages: Pre-built Images -------------------------------

      # nixos-images: NixOS installer image releases. Contains modules to make nixosConfigurations into installers
      # -  modules: nixos-images.nixosModules.{kexec-installer,netboot-installer,noninteractive}
      # - packages: nixos-images.packages.${system}.{kexec-installer-nixos-{2211,unstable}{,-noninteractive},netboot-{,installer-}nixos-{211,unstable}}
      nixos-images = {
        url = "github:nix-community/nixos-images";
      };


      # --- Packages: Package Management ------------------------------

      # nur-update: Update NUR
      nur-update = {
        url = "github:nix-community/nur-update";
      };

      nurl = {
        url = "github:nix-community/nurl";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # nix-init: Create Nix packages from repo URLs
      nix-init = {
        url = "github:nix-community/nix-init";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # nix-melt:
      # - packages: nix-melt.packages.${system}.default
      nix-melt = {
        url = "github:nix-community/nix-melt";
        inputs.nixpkgs.follows = "nixpkgs";
      }; # TODO: Install package

      # nvfetcher: Update source repos to reference in packages
      nvfetcher = {
        url = "github:berberman/nvfetcher";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      patsh = {
        url = "github:nix-community/patsh";
        inputs.nixpkgs.follows = "nixpkgs";
      }; # TODO: Install pkg

      patchelf = {
        url = "github:NixOS/patchelf";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # comma: Run packages without installing
      comma = {
        url = "github:nix-community/comma";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nix-portable = {
        url = "github:DavHau/nix-portable";
        inputs.nixpkgs.follows = "nixpkgs";
      }; # TODO: Install pkg

      # nix-doc: Documentation for Nix
      nixdoc = {
        url = "github:nix-community/nixdoc";
        inputs.nixpkgs.follows = "nixpkgs";
      }; # TODO: Install pkg

      # nix-index-database: Pre-built database for nix-index. Updated weekly. Import NixOS/hm modules.
      nix-index-database = {
        url = "github:Mic92/nix-index-database";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # qnr: Local Nix registry
      nix-quick-registry = {
        url = "github:divnix/quick-nix-registry";
      };

      # namaka: Snapshot testing for Nix # TODO: Install pkg
      namaka = {
        url = "github:nix-community/namaka";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      nixago = {
        url = "github:nix-community/nixago";
        inputs.nixpkgs.follows = "nixpkgs";
      }; # TODO: Collect lib
      nixago-extensions = {
        url = "github:nix-community/nixago-extensions";
        inputs.nixpkgs.follows = "nixpkgs";
      }; # TODO: Collect lib

      # nixpkgs-graph-explorer: CLI to explore nixpkgs graph
      nixpkgs-graph-explorer = {
        url = "github:tweag/nixpkgs-graph-explorer";
      };

      #nixpkgs-graph = {
      #  url = "github:tweag/nixpkgs-graph";
      #};

      # debnix: Convert debian dependencies to nixpkgs equivalents
      # - packages: debnix.packages.${system}.debnix
      debnix = {
        url = "github:ngi-nix/debnix";
      };


      # --- Packages: Nix --------------------------------------------

      # scanoss-nix: Scan OSS packages for vulns, misconfigs, etc.
      scanoss-nix = {
        url = "github:DeterminateSystems/scanoss-nix";
        flake = false;
      };

      # --- Nix Utils ------------------------------------------------

      nixt = {
        url = "github:nix-community/nixt";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      nix-alien = {
        url = "github:thiagokokada/nix-alien";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      nix-auto-changelog = {
        url = "github:loophp/nix-auto-changelog";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      nuenv = {
        url = "github:DeterminateSystems/nuenv";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      rnix-parser = {
        url = "github:nix-community/rnix-parser";
        inputs.nixpkgs.follows = "nixpkgs";
      }; # TODO: Install pkg
      harmonia = {
        url = "github:nix-community/harmonia";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      napalm = {
        url = "github:nix-community/napalm";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      naersk = {
        url = "github:nix-community/naersk";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # nix-health: Show health of your Nix system
      nix-health = {
        url = "github:srid/nix-health";
      };

      # saschagrunert/kubernix

      # kubenix: Kubernetes manifests via Nix config
      # -   modules: kubenix.nixosModules.kubenix
      # -  packages: kubenix.packages.${system}.{default,cli,docs,generate-{istio,k8s},kubectl,kubernetes,vals}
      # -  overlays: kubenix.overlays.default
      # -      apps: kubenix.apps.${system}.{docs,generate}
      # - devShells: kubenix.devShells.${system}.default
      kubenix = {
        url = "github:hall/kubenix";
      };

      # nix-policy: Apply Access Control Policies with Nix
      # -  packages: nix-policy.packages.${system}.{default,check-flake,flake-checker,rbac-eval,tfstate-eval}
      # -  overlays: nix-policy.overlays.default
      # - devShells: nix-policy.${system}.{default,ci}
      # -      libs: nix-policy.lib.?
      nix-policy = {
        url = "github:DeterminateSystems/nix-policy";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # nix-installer: Improved version of Nix/NixOS installer
      # - devShells: nix-installer.${system}.default (nix-install-shell)
      # -  packages: nix-installer.${system}.{default,nix-installer,nix-installer-static}
      # -  overlays: nix-installer.overlays.default
      nix-installer = {
        url = "github:DeterminateSystems/nix-installer";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # asset-tagger: Print asset tags
      # - devShells: asset-tagger.devShells.x86_64-linux.{default,asset}
      # -  packages: asset-tagger.packages.x86_64-linux.{default,asset-label-printer-main}
      asset-tagger = {
        url = "github:DeterminateSystems/asset-tagger";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # --- DevShells ------------------------------------------------

      # devshell: Developer shells
      devshell = {
        url = "github:numtide/devshell";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # devshell: go package to use YubiKey's PIV to login to Vault
      vault-credential-yubikey = {
        url = "github:grahamc/vault-credential-yubikey";
      };
      # devshell: go package to login once to Vault using github access tokens
      vault-plugin-secrets-github = {
        url = "github:martinbaillie/vault-plugin-secrets-github";
      };

      # jupyenv: Jupyter Notebooks environments
      # -  packages: jupyenv.packages.x86_64-linux.{default,docs,jupyterlab,jupyterlab-new,jupyterlab-{all-example-kernels,kernel-example-<LANG>-{minimal,science,stable}}}
      # -      apps: jupyenv.apps.x86_64-linux.update-poetry-lock
      # - devShells: jupyenv.devShells.x86_64-linux.default
      # - templates: jupyenv.templates.default - Jupyter Notebook in Nix project boilerplate
      # -      libs: jupyenv.lib.?
      jupyenv = {
        url = "github:tweag/jupyenv";
        inputs = {
          nixpkgs.follows = "nixpkgs";
          flake-compat.follows = "flake-compat";
          flake-utils.follows = "flake-utils";
          #rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
          #rust-overlay.inputs.flake-utils.follows = "flake-utils";
        };
      };

      # - packages: coricamu.packages.${system}.{docs,website-minified}
      # -     apps: coricamu.apps.${system}.docs-preview
      # -     libs: coricamu.lib.?
      #coricamu = {
      #  url = "github:danth/coricamu"; @  # Static site generator
      #};

      # microvm: Spin up lightweight VMs from your configurations
      # -  overlays: microvm.overlays.cloud-hypervisor-graphics
      # -   modules: microvm.nixosModules.{microvm,host}
      # -  packages: microvm.packages.${system}.{build-microvm, doc, mktuntap, microvm, prebuilt, cloud-hypervisor-graphics}
      # - templates: microvm.templates.microvm
      # TODO: List all outputs
      microvm = {
        url = "github:astro/microvm.nix";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # nmd: Nix Make Docs
      # - packages: nmd.packages.${system}.buildDocBookDocs: Generate DocBook Docs site for Nix modules
      # - overlays: nmd.overlay.default
      nmd = {
        url = "github:gvolpe/nmd";
      };

      # colmena: Declarative deployments for nixosConfigurations
      colmena = {
        url = "github:zhaofengli/colmena";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # --- Packages: Individual Packages ----------------------------

      nix-software-center = {
        url = "github:vlinkz/nix-software-center";
      };

      nixos-conf-editor = {
        url = "github:vlinkz/nixos-conf-editor";
      };

      icicle = {
        url = "github:snowflakelinux/icicle";
      };

      # tex2nix: Generate Texlive environment containing all document deps
      # - packages: tex2nix.packages.${system}.tex2nix
      tex2nix = {
        url = "github:Mic92/tex2nix";
        inputs.nixpkgs.follows = "nixpkgs";
        #inputs.utils.follows = "nixpkgs";
      };

      multifirefox = {
        url = "git+https://codeberg.org/wolfangaukang/multifirefox";
      };

    };

  outputs = { self, nixpkgs, nur, flake-utils, flake-utils-plus, std, hive, ... }@inputs:
    let

      this = import ./pkgs;

      #flake-utils.lib.eachDefaultSystem (system:
      #  let pkgs = nixpkgs.legacyPackages.${system}; in {
      #    nurpkgs = import nixpkgs { inherit system; };
      #  }
      #)

      #supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      #forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (s: f s);
      system = "x86_64-linux";
      #networks = import ./networks.nix;
      #machines = import ./machines.nix;
      #users = import ./users.nix;

      defaults = with inputs; {
        modules = rec {
          #installer = with nixos-images.nixosModules; [ noninteractive kexec-installer netboot-installer ];
          nixos = [
            agenix.nixosModules.default
            arion.nixosModules.arion
            disko.nixosModules.disko
            nixos-flatpak.nixosModules.default
            harmonia.nixosModules.harmonia
            home.nixosModules.home-manager { home-manager.sharedModules = hm; }
            impermanence.nixosModules.impermanence
            kubenix.nixosModules.kubenix
            lanzaboote.nixosModules.lanzaboote
            musnix.nixosModules.musnix
            #nix-data.nixosModules.${system}.nix-data
            nix-index-database.nixosModules.nix-index { programs.nix-index-database.comma.enable = true; }
            nix-minecraft.nixosModules.minecraft-servers
            nix-netboot-serve.nixosModules.nix-netboot-serve
            nix-serve-ng.nixosModules.default
            nixvim.nixosModules.nixvim
            nur.nixosModules.nur
            robotnix.nixosModule
            robotnix.nixosModules.attestation-server
            snowflake.nixosModules.snowflake
            scalpel.nixosModule
            sops-nix.nixosModules.sops
            #stylix.nixosModules.stylix
            systemd-vaultd.nixosModules.vaultAgent
            systemd-vaultd.nixosModules.systemdVaultd
            vaultModule.nixosModule
            vscode-server.nixosModule
          ];
          darwin = [
            agenix.nixDarwinModules.default
            home.darwinModule
            nixvim.nixDarwinModules.default
            #stylix.darwinModules.stylix
          ];
          hm = [
            agenix.homeManagerModules.default
            arkenfox.hmModules.default
            home-extra-xhmm.homeManagerModules.all
            nix-index-database.hmModules.nix-index { programs.nix-index-database.comma.enable = true; }
            nixos-flatpak.homeManagerModules.default
            nixpkgs-android.hmModule
            nixvim.homeManagerModules.nixvim
            sops-nix.homeManagerModules.sops
            #stylix.homeManagerModules.stylix
          ];
          system = [ ];
          nix-on-droid = [ ];
          wsl = [ ];
          nix = [ ];
          flake-parts = [
            devshell.flakeModule
            flake-root.flakeModule
            mission-control.flakeModule
            treefmt-nix.flakeModule
          ];
        };
        overlays = {
          nixos = [
            nix-minecraft.overlay
            lanzaboote.overlays.default
          ];
          darwin = [
          ];
          hm = [
          ];
          nix = [
            self.overlays.default
            agenix.overlays.default
            comma.overlays.default
            fenix.overlays.default
            harmonia.overlays
            kubenix.overlays.default
            mineflake.overlays.default
            neovim-nightly-overlay.overlay
            #nix-vscode-extensions.overlays.default
            nixgl.overlay
            nixpkgs-mozilla.overlay
            nixpkgs-terraform-providers.overlay
            nixpkgs-wayland.overlay
            nmd.overlays.default
            nuenv.overlays.default
            nur.overlay
            nurl.overlay
            patchelf.overlays.default
            rnix-parser.overlay
            #terrasops.overlay
            { devour-flake = self.callPackage inputs.flake-devour {}; }
          ];
        };
      };
    in
    #flake-utils.lib.eachSystem [ "aarch64-linux" "x86_64-linux" ]A (system:
      #let pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.default ];};)
    flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = nixpkgs.legacyPackages.${system} // {
          overlays = [
            self.overlays.default
            inputs.nixpkgs-mozilla.overlay
            inputs.nuenv.overlays.default # https://determinate.systems/posts/nuenv
            inputs.nur.overlay
            inputs.nurl.overlay
            inputs.nix-alien.overlays.default
            #inputs.terrasops.overlay
          ];
        };
        in
        rec {
          packages = this.packages pkgs; # // { inherit (pkgs) terrasops; };
          legacyPackages = pkgs;
          devShells.default = with pkgs; mkShell {
            nativeBuildInputs = [
              colmena
              mdbook
              #terrasops
              nvfetcher
            ];
          };
          #formatter = pkgs.nixpkgs-fmt;
          formatter = inputs.treefmt-nix.lib.mkWrapper pkgs {
            projectRootFile = "flake.nix";
            programs.nixpkgs-fmt.enable = true;
            #programs.alejandra.enable = true;
          };
        }) // (std.growOn
        { # --- Declare projects & component types here ---
          inherit inputs;
          # blockTypes:
          # - std:  anything, arion, containers, data, devshells, files, functions, installables, microvms, nixago, nomadJobManifests, pkgs, runnables
          # - hive: colmenaConfigurations, darwinConfigurations, diskoConfigurations, homeConfigurations, nixosConfigurations
          cellsFrom = ./cells;
          cellBlocks = [
            (std.blockTypes.installables "packages"  {ci.build = true;})
            (std.blockTypes.devshells    "devshells" {ci.build = true;})
          ];
        }
        { # --- Declare collected output structure here ---
          # TODO: Create `nixosModules`, `homeManagerModules`, & `flakeModules`
          devShells = std.harvest self [ "flatpakify" "devshells" ];
          packages  = std.harvest self [ "flatpakify" "packages"  ];
        }) //
      {
      overlays.default = final: prev: (nixpkgs.lib.composeExtensions this.overlay final prev);

      #darwinConfigurations."m2" = nixpkgs.lib.darwinSystem {
      #  system = "aarch64-darwin";
      #
      #  modules = defaults.modules.darwin ++ [
      #    ./hosts/m2
      #    home.darwinModule {
      #      home-manager = {
      #        extraSpecialArgs = { inherit self inputs system; };
      #        sharedModules = defaults.modules.hm ++ self.homeManagerModules ++ ./users/common;
      #        useGlobalPkgs = true;
      #        useUserPackages = true;
      #        users = {
      #          guest = import ./users/guest/home.nix;
      #          main  = import ./users/main/home.nix;
      #        };
      #      };
      #    }
      #  ];
      #};

      nixosConfigurations."fw" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = with inputs; [
          ./hosts/fw/configuration.nix
          snowflake.nixosModules.snowflake
          nix-data.nixosModules.${system}.nix-data
          nixos-hardware.nixosModules.framework-12th-gen-intel
          nixvim.nixosModules.nixvim
          nur.nixosModules.nur
          agenix.nixosModules.default
          sops-nix.nixosModules.sops
          home.nixosModules.home-manager
          {
            home-manager = {
              #(import ./profiles/home-manager.nix { inherit self inputs system; users.sam = (import ./users/sam {}); });
              sharedModules = [
                #impermanence.nixosModules.home-manager
                #(import ./users/default/nixos {};)
                arkenfox.hmModules.default
                nixpkgs-android.hmModule
                sops-nix.homeManagerModules.sops
              ];
              useGlobalPkgs = false;
              useUserPackages = true;
              extraSpecialArgs = { inherit self inputs system; };
              users.sam = import ./users/sam; # ./users/sam/home.nix
            };
          }
        ];
        specialArgs = { inherit self inputs system; };
      };

      nixosConfigurations.fajita = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          { _module.args = { inherit inputs; }; }
          (import "${inputs.nixos-mobile}/lib/configuration.nix" { device = "oneplus-fajita"; })
          ./hosts/fajita/configuration.nix
          inputs.snowflake.nixosModules.snowflake
          inputs.nix-data.nixosModules."aarch64-linux".nix-data
          inputs.nixpkgs-gnome-mobile.nixosModules.gnome-mobile
        ];
        specialArgs = { inherit self inputs system; };
      };
      fajita-fastboot-images = inputs.self.nixosConfigurations.fajita.config.mobile.outputs.android.android-fastboot-images;
      fajita-flashable-zip = inputs.self.nixosConfigurations.fajita.config.mobile.outputs.android.android-flashable-zip;

      #homeConfigurations.sam = inputs.home.lib.homeManagerConfiguration {
      #  inherit pkgs;
      #  modules = [
      #    ./users/sam   #./users/sam/home.nix
      #  ];
      #};


      #modules = flake-utils.lib.eachDefaultSystem (system: let
      #  inherit inputs;
      #  nurpkgs = import nixpkgs {inherit system;};
      #in [
      # NUR repos via package overrides
      #{ nixpkgs.config.packageOverrides = pkgs: {
      #  inherit inputs system;
      #  nur = import inputs.nur {
      #    inherit pkgs nurpkgs;
      #    repoOverrides = {
      #      #local     = import inputs.nur-local { inherit pkgs; };
      #      #publicSam = import inputs.nur-repo { inherit pkgs; };
      #    };
      #  }; };
      #}
      # NUR repos via overlays
      #{ nixpkgs.overlays = let pkgs = nixpkgs.legacyPackages.${system}; in [ (final: prev: {
      #  inherit inputs system pkgs;
      #  #pkgs = import nixpkgs {inherit system;};
      #  nur = import inputs.nur {
      #    inherit pkgs nurpkgs;
      #    repoOverrides = {
      #      #local    = import inputs.nur-local { inherit pkgs; };
      #      #publicSam = import inputs.nur-repo { inherit pkgs; };
      #    };
      #  };
      #})];
      #}
      #]); # --- End: outputs.modules ---
      apps.nextcloud-next26 = let helmish = inputs.nix-helm.deployments; in
        helmish: {
          nextcloud = import ./helm/nextcloud.nix { inherit helmish; };
        };
    }; # --- End: outputs ---

}

