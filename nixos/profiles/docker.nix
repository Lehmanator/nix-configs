{ inputs, config, lib, pkgs, user, ... }:
{
  # TODO: Handle general config, docker-specifics, & podman-specifics in separate configs?
  virtualisation.oci-containers.backend = lib.mkDefault "docker";

  virtualisation.docker = {
    enable = false;
    enableOnBoot = true;
    package = lib.mkDefault pkgs.docker;

    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ ];
    };

    # Configuration for docker daemon. Attributes serialized to JSON used as daemon.conf
    # https://docs.docker.com/engine/reference/commandline/dockerd/#daemon-configuration-file
    daemon.settings = {
      fixed-cidr-v6 = lib.mkIf config.networking.enableIPv6 "fd00::/80";
      ipv6 = config.networking.enableIPv6;
    };
    # https://github.com/NixOS/nixpkgs/issues/24318#issuecomment-289216273
    extraOptions = lib.mkIf config.networking.nftables.enable "--iptables=False";
    extraPackages = [pkgs.criu];

    # List of unix & TCP docker should listen to.
    #  Format follows ListenStream as described in systemd.socket(5)
    # TODO: Add user sockets? Add podman sockets?
    listenOptions = ["/run/docker.sock"];

    # Allow dockerd to be restarted w/o affecting running container.
    # NOTE: Option incompatible w/ docker swarm
    liveRestore = true; 

    logDriver = "journald"; # *journald | none | json-file | syslog | gelf | fluentd | awslogs | splunk | etwlogs | gcplogs | local

    #storageDriver = null; # null | aufs | btrfs | devicemapper | overlay | overlay2 | zfs

    # Enables docker in rootless mode, a daemon that manages linux containers.
    #   To interact w/ daemon, one needs to set: `DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
    rootless = {
      enable = true; 
      #package = lib.mkDefault pkgs.docker;

      daemon.settings = {
        fixed-cidr-v6 = lib.mkIf config.networking.enableIPv6 "fd00::/80";
        ipv6 = config.networking.enableIPv6;
      };

      # Point DOCKER_HOST to rootless Docker instance for normal users by default
      setSocketVariable = true; 
    };

  };

  # Enable default user in podman group so user can run podman commands without sudo
  users.users.${user}.extraGroups = config.virtualisation.oci-containers.backend; # ["docker" "podman"];

  #networking.nftables.enable = false;
}
