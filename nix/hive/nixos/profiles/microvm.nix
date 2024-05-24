{ inputs, config, lib, pkgs, user, ... }:
{
  # https://github.com/nix-community/nixvim
  imports = [
    inputs.microvm.nixosModules.host
    inputs.microvm.nixosModules.microvm
  ];

  # TODO: Default system config
  microvm = {
    host.enable = lib.mkDefault true;
    guest.enable = !(config.microvm.host.enable);
    autostart = lib.mkDefault [ ];
    stateDir = lib.mkDefault "/var/lib/microvms";
    vms = {
      name = {
        autostart = true;
        flake = inputs.self; #flake = self;
        pkgs = inputs.nixpkgs-unstable { system="x86_64-linux"; };
        restartIfChanged = true;
        specialArgs = { inherit inputs pkgs user; };
        updateFlake = "git+file:///etc/nixos"; # Specify from where to let `microvm -u` update later on
        #config = lib.mkDefault config; #({config, name, ...}: {});
        # https://github.com/astro/microvm.nix/blob/main/nixos-modules/microvm/options.nix
        config = {
          microvm = let
            vm-name = "microvm";
          in {
            inherit user;
            host.enable = false;
            guest.enable = true;
            balloonMem = "4096"; # Memory size that host can request to be freed by VM.
            cpu = "x86_64";
            crosvm={pivotRoot=""; extraArgs=[];};
            devices = [ # PCI / USB devices for host-to-vm passthrough
              { bus="pci"; path="0000:01:00.0"; }
              { bus="pci"; path="0000:01:01.0"; }
              { bus="usb"; path="vendorid=0xabcd,productid=0x0123"; } # QEMU-only !
            ];
            # TCP/UDP port forwarding (QEMU user-networking only)
            forwardPorts = [ # from=host|guest, proto=tcp|udp,
              { from="host";  host.port=10022; guest.port=22;  }
              { from="host";  host.port=10053; guest.port=53;  }
              { from="host";  host.port=10080; guest.port=80;  }
              { from="host";  host.port=10443; guest.port=443; }
              { from="guest"; host.port=10180; guest.port=81; host.address="127.0.0.1"; guest.address="10.0.2.10"; }
            ];
            graphics={enable=true; socket="${config.networking.hostName}-gpu.sock";}; # Path of vhost-user socket.
            hugepageMem = false; #
            hypervisor = ""; #           # Hypervisor to use by default in `microvm.declaredRunner`
            interfaces = [ #             # Network Interfaces
              { id="vm-${vm-name}"; #    # Interface name on the host
                bridge=""; #             # Attach network interface to host interface for type=macvlan
                mac="02:00:00:00:00:01"; # Eth MAC addr of MicroVM guest's network interface (not the host's)
                type="user"; #           # user (qemu-only) | tap (tuntap) | macvtap (attach to host's physical net interface | bridge (attach qemu-created tap interface to a bridge)
                macvtap={  #
                  link=""; # Attach network interface to host interface for type=macvlan
                  mode=""; # MACVLAN mode to use. (private | vepa | bridge | passthru | source)
                };
              }
            ];
            kernelParams = [""]; # `boot.kernelParams`, without ending up in `system.build.toplevel`, saving rebuilds
            kernel = config.boot.kernelPackages.kernel;
            initrdPath = "${config.system.build.initialRamdisk}/${config.system.boot.loader.initrdFile}";
            mem = 512; # RAM allocation in MB.
            preStart = ''
            ''; # Commands to run before starting the hypervisor
            qemu.extraArgs = [""]; # Extra arguments to pass to QEMU.
            runner = {};
            shares = [ # Shared filesystem directories (protos: virtiofs | 9p)
              # Share directories from host (source/socket) -> VM (mountPoint)
              # Pass logs from VM -> host
              {proto="virtiofs"; tag="journal";   socket="journal.sock";            mountPoint="/var/log/journal";}
              {proto="virtiofs"; tag="ro-store";  source="/nix/store";              mountPoint="/nix/.ro-store";}
              {proto="virtiofs"; tag="downloads"; source="/home/${user}/Downloads"; mountPoint="/home/${user}/Downloads";}
              {proto="virtiofs"; tag="public";    source="/home/${user}/Public";    mountPoint="/home/${user}/Public";}
            ];
            socket = "${config.networking.hostName}.sock"; # Control socket for Hypervisor so MicroVM can be shutdown cleanly.
            storeOnDisk = false; # Enables store on boot squashfs even in presence of share with host's /nix/store
            vcpu = 4; # Number of virtual CPU cores
            vsock.cid = 0; # Virtual Machine address. Setting it enables `AF_VSOCK`. Reserved: 0=hypervisor, 1=loopback, 2=host
            volumes = [{ # Block device images
              image = "";  # Path to disk image on the host
              mountPoint = "/nix/.rw-store"; # Where to mount the volume inside the container.
              size = 1024;  # Volume size if created automatically
              autoCreate = true; # Create image on host automatically before start?
              fsType = "ext4"; # Filesystem for automatic creation & mounting.
            }];
            writableStoreOverlay = "/nix/.rw-store"; # Optional string of the path where all writes to /nix/store should go to.
          };
        };
      };
    };
  };

  systemd.tmpfiles.rules = lib.mkIf config.microvm.host.enable map (vmHost: let
    machineId = inputs.self.lib.addresses.machineId.${vmHost};
    #machineId = self.lib.addresses.machineId.${vmHost};
  in
  # Creates a symlink of each MicroVM's journal under the host's /var/log/journal
  "L+ /var/log/journal/${machineId} - - - - /var/lib/microvms/${vmHost}/journal/${machineId}"
  ) (builtins.attrNames inputs.self.lib.addresses.machineId);
  #) (builtins.attrNames self.lib.addresses.machineId);

  # TODO: Conditional if module loaded
  #environment.persistence."/nix/persist".directories = lib.mkIf config.microvm.host.enable [ config.microvm.stateDir ];

  # Flake updates from CI / Hydra jobs
  environment.systemPackages = let
    git = {
      host="https://github.com";
      owner = "lehmanator";
      repo = "nix-configs";
      ref = "develop";
    };
    hydraHost="https://hydra.${config.networking.domain}";
    binaryCacheHost="https://nix-cache.${config.networking.domain}";
  in [(
    # Provide a manual updating script that fetches the latest
    # updated+built system from Hydra
    pkgs.writeScriptBin "update-microvm" ''
      #! ${pkgs.runtimeShell} -e

      if [ $# -lt 1 ]; then
        NAMES="$(ls -1 /var/lib/microvms)"
      else
        NAMES="$@"
      fi

      for NAME in $NAMES; do
        echo MicroVM $NAME
        cd ${config.microvms.stateDir}/$NAME
        # Is this truly the flake that is being built on Hydra?
        if [ "$(cat flake)" = "git+${git.host}/${git.owner}/${git.repo}?ref=${git.ref}" ]; then
          NEW=$(curl -sLH "Accept: application/json" ${hydraHost}/job/${git.owner}/${git.repo}/$NAME/latest | ${pkgs.jq}/bin/jq -er .buildoutputs.out.path)
          nix copy --from ${binaryCacheHost} $NEW

          if [ -e booted ]; then
            nix store diff-closures $(readlink booted) $NEW
          elif [ -e current ]; then
            echo "NOT BOOTED! Diffing to old current:"
            nix store diff-closures $(readlink current) $NEW
          else
            echo "NOT BOOTED?"
          fi

          CHANGED=no
          if ! [ -e current ]; then
            ln -s $NEW current
            CHANGED=yes
          elif [ "$(readlink current)" != $NEW ]; then
            rm -f old
            cp --no-dereference current old
            rm -f current
            ln -s $NEW current
            CHANGED=yes
          fi
        fi

        if [ "$CHANGED" = "yes" ]; then
          systemctl restart microvm@$NAME
        fi
        echo
      done
    ''
  )];

  # TODO: Configure options: microvm.declaredRunner & microvm.runners

  # TODO: Set guest VM options
  # https://astro.github.io/microvm.nix/microvm-options.html
}
