{ self, inputs, cell, }: {
  system = "x86_64-linux";
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
      targetHost = "127.0.0.1";
      #tags = ["test"];
    };
  };
  nixosConfiguration = {
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "24.05";
    bee = {
      inherit (self) system;
      inherit (inputs) darwin;
      home = inputs.home-manager;

      # TODO: import from cell.pkgs.<name>
      pkgs = import inputs.nixpkgs {
        inherit (self) system;
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
    };
    imports = with inputs;
      [
        # --- omnibus ---
        #agenix.nixosModules.age
        arion.nixosModules.arion
        disko.nixosModules.default
        microvm.nixosModules.host
        ragenix.nixosModules.age
        #snapshotter.nixosModules.default #containerd k3s nix-snapshotter preload-containerd (all have -rootless versions)
        sops-nix.nixosModules.sops
        srvos.nixosModules.desktop
        srvos.nixosModules.server
        srvos.nixosModules.mixins-nginx
        srvos.nixosModules.mixins-nix-experimental
        srvos.nixosModules.mixins-systemd-boot
        srvos.nixosModules.mixins-telegraf
        srvos.nixosModules.mixins-terminfo
        srvos.nixosModules.mixins-tracing
        srvos.nixosModules.mixins-trusted-nix-caches
        #srvos.nixosModules.roles-github-actions-runner
        srvos.nixosModules.roles-nix-remote-builder
        srvos.nixosModules.roles-prometheus

        # --- flake.nix ---
      ] ++ (with cell.nixosProfiles; [
        # --- std ---
        cell.nixosModules.debug
        activitywatch
        adb
        agenix
        apparmor
        appimage
        arion
        auditd
        cachix-agent
        colmena
        containerd
        cri-o
        envfs
        flake-utils-plus
        #flatpak-declarative
        gdm
        gnome.default
        gtk
        desktop
        hercules-ci
        home-manager
        homed
        kvm
        lanzaboote
        libreoffice
        libvirt
        locale-est
        lxc
        lxd
        lxd-image-server
        motd
        neovim
        networkmanager
        nixos-generators
        nixvim
        normalize
        nur
        nushell
        ollama
        pipewire
        plymouth
        podman
        polkit
        printing
        qemu
        quick-nix-registry
        resolvconf
        robotnix
        rxe
        sits
        sops
        sshd
        sudo-rs
        systemd-boot
        systemd-emergency
        systemd-initrd
        systemd-repart
        test
        unl0kr
        ucarp
        user-primary
        vm-guest-windows
        vm-host
        waydroid
        wayland
        wine
        xserver-base

        #avahi # Conflict w/ systemd-resolved
        bluetooth
        dns-base
        #dnscrypt-proxy # Conflict w/ systemd-resolved
        fprintd
        hosts-blocking
        systemd-networkd-wireguard # Needs secret
        systemd-resolved # Conflict w/ dnscrypt-proxy
        tailscale
        tailscale-mullvad-exit-node
        tailscale-subnet-router
        tpm2
        wifi
        #wifi-hotspot # Needs radio interface name & password secret
        wireguard
        wireguard-automesh

        (self + /hosts/fw/hardware-configuration.nix)

        #harmonia # Wants secret
        #impermanence # Wants user
        #installer # ???
        #iscsi-initiator # Not using
        #kubenix # Needs fix
        #microvm # Needs fix
        #nix-index # ??
        #nixified-ai # Dep broken
        #nixos-images # Only loaded in images?
        #qemu-web # Wants secret
        #rygel # Needs fix to work with nftables
        #secureboot # Incompatible with systemd-boot
        #snowflake # No longer using
        #specialization # Fixme
        #ssbm-nix # Broken package
        #stylix # Needs image path
        #systemd-debug # Kernel patches cause long rebuild
        #systemd-networkd # Needs options fix
        #tor # Needs secret?

        #inputs.cells.android.nixosModules.attestation-server
      ]);
    xdg.portal.enable = true;
    #networking.hostName = "minimal";
    #home-manager.users.sam = ./users/sam;
  };
}
