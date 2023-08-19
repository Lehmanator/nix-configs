{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
    ../../apparmor.nix
    ./containerd.nix
    ./cri-o.nix
    ./lxc.nix
    ./lxd.nix
    ./lxd-image-server.nix
    ./lxd.nix
    ./podman.nix
  ];

  # Common config module in: `/etc/containers`
  virtualisation.containers = {
    enable = true;

    containersConf = {
      cniPlugins = [
        pkgs.cni-plugins          # dhcp host-local static bridge dummy host-device ipvlan loopback macvlan ptp tap vlan bandwidth firewall portmap sbr tuning vrf
        pkgs.dnsname-cni          # DNS name resolution for containers
        #pkgs.calico-cni-plugin   # Cloud native networking & network security
        #pkgs.multus-cni          # Attaching multiple network interfaces to pods
        #pkgs.cni-plugin-flannel  # IPv4 network b/w multiple nodes in a cluster. Not how containers are networked to host, only how traffic is transported b/w hosts.
      ];

      # Configuration for containers.conf
      settings = {
      };
    };

    ociSeccompBpfHook.enable = false;   # TODO: What is this?

    # Signature verification policy file.
    #    If option empty, the default policy file from `skopeo` is used.
    policy = {
      #default = [ {type="insecureAcceptAnything";} ];
      #transports = {
      #  docker-daemon = {
      #    "" = [ {type="insecureAcceptAnything";} ];
      #  };
      #};
    };

    registries = {
      block    = []; # List of registries to block
      insecure = []; # List of insecure repositories
      search   = [ "docker.io" "quay.io" "gcr.io" "ghcr.io" ];
    };

    # Configuration: storage.conf
    storage.settings = {
      storage = {
        driver = "overlay";
        graphroot = "/var/lib/containers/storage";
        runroot = "/run/containers/storage";
      };
    };
  };


  # --- Containers -------------------------------------------------------------
  virtualisation.oci-containers.containers = { # OCI (Docker) containers to run as systemd services
    #<name> = {
    #  autoStart = true;
    #  cmd = ["--port=9000"];
    #  dependsOn = ["<name1>"];                # Names of other oci-containers this one depends on. Added to unit's After & Requires
    #  entrypoint = "/bin/my-app";             # Default image entrypoint
    #  environment = { DB_PORT="3306"; };      # Image environment variables
    #  environmentFiles = [ /path/to/.env ..]; # Files containing environment variables to set in container.
    #  extraOptions = [ "--network=host" ];    # Extra options/flags for `podman run`
    #  image = "library/hello-world";          # OCI image to run
    #  imageFile = pkgs.dockerTools.buildImage {...}; # Path to an image file to load before running image. Can be used to bypass pulling image from registry. Attr `image` must match the name & tag of the image contained in this file.
    #  log-driver = "journald";                #
    #  login = {
    #    passwordFile = "/etc/nixos/dockerhub-passwd";  # PAth to file containing password
    #    registry = "https://docker.pkg.github.com";
    #    username = "<registryUsername>";
    #  };
    #  ports = [ # Formats:                    # Network ports to publish from the container to the outer host.
    #    "<ip>:<hostPort>:<containerPort>"     #   e.g. "8080:9000"
    #    "<ip>::<containerPort>"               # <hostPort> & <containerPort> can be specified as range of ports.
    #    "<hostPort>:<containerPort>"          #   - If both ranges, they must be the same size.
    #    "<containerPort>"                     #   - If only range for <hostPort>, containerPort must not be a range.
    #  ];                                      # See: https://docs.docker.com/engine/reference/run/#expose-incoming-ports
    #  user = "nobody:nogroup";                # Modify username/UID or groupname/GID used in container
    #  volumes = [                             # List of volumes to attach to this container. Format: "src:dst"
    #    "<volume_name>:/path/inside/container"
    #    "/path/on/host:/path/inside/container"
    #  ];
    #  workdir = "/var/lib/hello_world";       # Override default working directory for the container.
    #};
  };

  # Set of NixOS system configurations to be run as lightweight containers.
  #   Each container appears as a service `container-<name>` on host system, allowing to be controlled by `systemctl`
  containers = {
    #<name> = {
    #  additionalCapabilities = [ "CAP_NET_ADMIN" "CAP_MKNOD" ];
    #  allowedDevices = {
    #    modifier = "rw";        # Device node access modifier. Combo of r, w, & m (mknod). See: systemd.resource-control(5)
    #    node = "/dev/net/tun";  # Path to device node
    #  };
    #  autoStart = false;
    #  bindMounts = {
    #    <name> = {
    #      hostPath = "/home/username/some_directory";
    #      isReadOnly = true;
    #      mountPoint = "/mnt/usb";   # Mount point on container file system.
    #    };
    #  };
    #  config = <Top-Level_NixOS_config>;    # Specification of the desired configuration of the container as a NixOS module
    #  enableTun = true;
    #  ephemeral = true;  # Runs container in ephemeral mode w/ empty root fs at boot. Container will be bootstrapped from scratch on each boot & cleaned up on shutdown, leaving no traces behind. Useful for stateless, reproducible containers. Note: Might want to set `systemd.network.networks.$interface.dhcpV4Config.ClientIdentifier = mac` if you use `macvlans` option. This way, DHCP client ID will be stable b/w container restarts.
    #  extraFlags = ["--drop-capability=CAP_SYS_CHROOT"];
    #  extraVeths = {  # Extra veth-pairs to be created for the container
    #    <name> = {
    #      forwardPorts = [  # List of forwarded ports from host to container. Each port forward is specified by protocol, hostPort, & containerPort. By default, protocol=tcp, hostPort=containerPort if containerPort=null.
    #         { protocol="tcp"; hostPort=8080; containerPort=80; }
    #      ];
    #      hostAddress  = "10.231.136.1";  # IPv4 addr assigned to host interface (Not used when hostBridge is set)
    #      hostAddress6 = "fc00::1";       # IPv4 addr assigned to host interface (Not used when hostBridge is set)
    #      hostBridge = "br0";             # Put the host-side of the veth-pair into the named bridge. Incompat w/ hostAddress (6)
    #      localAddress = "10.231.136.2";  # IPv4 addr assigned to the interface in the container. If a hostBridge is used, this should be given w/ netmask to access the whole network. Otherwise, default mask is /32 & routing is set up from localAddress to hostAddress & back.
    #      localAddress6 = "fc00::2";  # IPv4 addr assigned to the interface in the container. If a hostBridge is used, this should be given w/ netmask to access the whole network. Otherwise, default mask is /32 & routing is set up from localAddress to hostAddress & back.
    #    };
    #  };
    #  forwardPorts = [ {protocol="tcp"; hostPort=8080; containerPort=80; } ];
    #  hostAddress = "..."; hostAddress6 = "..."; hostBridge = "...";
    #  localAddress= "..."; localAddress6= "...";
    #  interfaces = ["eth1" "eth2"];
    #  macvlans = ["eth1" "eth2"];
    #  nixpkgs = pkgs.path;   # PAth to the nixpkgs that provide the modules, pkgs, & lib for container eval. Setting config.nixpkgs.pkgs = pkgs speeds up container eval by reusing the system pkgs, but the `nixpkgs.config` option in the container is ignored in this case
    #  path = "/nix/var/nix/profiles/per-container/webserver";  # Alternative to specifying `config` by specifying the path to eval'd NixOS system config, typically a symlink to a system profile.
    #  privateNetwork = false;  # Give container its own private virtual Ethernet interface (eth0) is hooked up to the interface `ve-<containerName> on the host. If unset, the container shares the network interfaces of the host & can bind to any port on any interface.
    #  specialArgs = {};  # Special set of args passed to NixOS modules that get merged into the `specialArgs` used to eval NixOS configs
    #  timeoutStartSec = "1min";
    #  tmpfs = [ "/var" ];
    #};
  };


  # Whether to enable extra-container, a tool for running declarative NixOS containers without host system rebuilds .
  programs.extra-container.enable = true;

  # In containers, whether to use the resolv.conf supplied by the host. (only in containers?)
  #networking.useHostResolvConf = true;
}
