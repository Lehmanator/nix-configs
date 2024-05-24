{ inputs, config, lib, pkgs, user, ... }: {
  virtualisation = {
    oci-containers.backend = lib.mkDefault "docker";
    docker = {
      enable = false;
      enableNvidia = lib.mkDefault
        false; # Enable nvidia-docker wrapper, supporting NVIDIA GPUs inside docker containers.
      enableOnBoot = true;
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
      extraOptions =
        lib.mkIf config.networking.nftables.enable "--iptables=False";
      extraPackages = [ pkgs.criu ];
      listenOptions = [
        "/run/docker.sock"
      ]; # List of unix & TCP docker should listen to. Format follows ListenStream as described in systemd.socket(5)
      liveRestore =
        true; # Allow dockerd to be restarted w/o affecting running container. Option incompatible w/ docker swarm
      logDriver =
        "journald"; # *journald | none | json-file | syslog | gelf | fluentd | awslogs | splunk | etwlogs | gcplogs | local
      package = pkgs.docker;
      rootless = {
        enable =
          true; # Enables docker in rootless mode, a daemon that manages linux containers. To interact w/ daemon, one needs to set: `DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
        daemon.settings = {
          fixed-cidr-v6 = lib.mkIf config.networking.enableIPv6 "fd00::/80";
          ipv6 = config.networking.enableIPv6;
        };
        #package = pkgs.docker;
        setSocketVariable =
          true; # Point DOCKER_HOST to rootless Docker instance for normal users by default
      };
      #storageDriver = null; # null | aufs | btrfs | devicemapper | overlay | overlay2 | zfs
    };
  };

  # Enable default user in podman group so user can run podman commands without sudo
  users.users.${user}.extraGroups = [ "docker" ];

  #networking.nftables.enable = false;
}
