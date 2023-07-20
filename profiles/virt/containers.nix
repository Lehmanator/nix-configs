{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
  ];

  virtualisation.docker = {
    enable = false;
    rootless.enable = true;
    rootless.setSocketVariable = true;
  };
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerSocket.enable = true;
    dockerCompat = true;
    defaultNetwork.settings = {
      dns_enabled = true;
      dnsname.enable = true;
    };
    #extraPackages = [];
    #networkSocket = {
    #  enable = true;
    #  listenAddress = "0.0.0.0";
    #  openFirewall = true;
    #  port = 2376;
    #  server = "ghostunnel";
    #  tls.cacert = <PATH>;
    #  tls.cert = <PATH>;
    #  tls.key = <PATH>;
    #};
  };
  virtualisation.oci-containers.backend = "podman";
  users.users."${user}".extraGroups = ["docker" "podman"];
  virtualisation.containerd = {
    enable = true;
    #configFile = null;
    #args = {};
    #settings = {};
  };
  virtualisation.containers = {
    enable = true;
    #ociSeccompBpfHook.enable = false;
    #containersConf.cniPlugins = [ pkgs.cni-plugins ];
    #containersConf.settings = {};
    registries.search = [ "docker.io" "quay.io" "gcr.io" "ghcr.io" ];
  };
  #virtualisation.cri-o.enable = true;

  virtualisation.lxc = {
    enable = true;  # This enables Linux Containers (LXC), which provides tools for creating and managing system or application containers on Linux.
    lxcfs.enable = true; # This enables LXCFS, a FUSE filesystem for LXC
    defaultConfig = "lxc.include = ${pkgs.lxcfs}/share/lxc/config/common.conf.d/00-lxcfs.conf";
  };

  virtualisation.lxd = {
    enable = true;
    recommendedSysctlSettings = true;
  };

  # Whether to enable extra-container, a tool for running declarative NixOS containers without host system rebuilds .
  programs.extra-container.enable = true;

  # In containers, whether to use the resolv.conf supplied by the host. (only in containers?)
  #networking.useHostResolvConf = true;
}
