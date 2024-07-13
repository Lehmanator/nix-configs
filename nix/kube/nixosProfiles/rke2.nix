{ config, lib, pkgs
, master ? false
, rootless ? true
, dualstack ? true
# https://docs.rke2.io/networking/multus_sriov
, multus ? true
, nodelocal-dnscache ? true
,  ...
}:
let
  inherit (lib) optional optionals optionalString;
  # Also check out RKE2: https://docs.rke2.io/
  # https://rootlesscontaine.rs/

in
{
  services.rke2 = {
    enable = true;
    cisHardening = lib.mkDefault true;
    cni = lib.mkDefault "canal";

    # File path containing k3s YAML config.
    # This is useful when the config is generated (for example on boot).
    configPath = lib.mkDefault "/etc/rancher/rke2/config.yaml";
    dataDir = lib.mkDefault "/var/lib/rancher/rke2";
    debug = lib.mkDefault true;
    disable = lib.mkDefault [];

    # env vars for k3s service. See: See systemd.exec(5).
    # Server: https://docs.rke2.io/reference/server_config
    # Agent: https://docs.rke2.io/reference/linux_agent_config
    environmentVars = {};

    # k3s CLI args
    extraFlags = lib.cli.toGNUCommandLineShell {} {
      cluster-cidr = "10.42.0.0/16" + optionalString dualstack ",2001:cafe:42::/56";
      service-cidr = "10.43.0.0/16" + optionalString dualstack ",2001:cafe:43::/112";
      cni = (lib.optionalString multus "multus,") + "canal";
      # no-deploy = "traefik";

      # Deploy ServiceLB load balancer w/ RKE2/K3S
      serviceLB = lib.mkDefault true;
    };

    nodeIP = lib.mkDefault null;
    nodeLabel = ["nixos"];
    nodeName = lib.mkDefault config.networking.hostName;
    nodeTaint = lib.mkDefault [];

    package = lib.mkDefault pkgs.rke2;
    selinux = lib.mkDefault true;

    # Whether k3s should run as a server or agent.
    # - Servers also run as agents
    # - Servers start by default as standalone using embedded sqlite datastore
    # - clusterInit=true switches to embedded etcd datastore & enables HA mode
    # - serverAddr="<addr>" joins an already-initialized HA cluster
    role = "server"; #"agent";

    # Configure to join already-initialized HA cluster.
    #  Required if role="agent"
    # Servers & agents need to communicate each other.
    # Read networking docs for how to configure firewall:
    #   https://docs.k3s.io/installation/requirements#networking
    serverAddr = "https://10.0.0.10:6443";

    # The k3s token to use when connecting to a server.
    # agentToken = config.sops.secrets.rke2-agent-token.path;
    tokenFile = config.sops.secrets.rke2-token.path;
  };

  sops.secrets = {
    rke2-agent-token = {};
    rke2-token = {};
  };

  # https://docs.k3s.io/advanced
  environment.systemPackages = [
    pkgs.etcdctl
    # https://docs.rke2.io/backup_restore
    # TODO: Commands to restore snapshots
    # TODO: Commands to backup snapshots to S3
  ];

  # CNI Plugins: https://www.cni.dev/plugins/current/
  # TODO: Possible to write YAML as Nix attrs?
  kubernetes.api.resources.helmchartconfig = {
    rke2-canal = lib.mkIf (config.services.rke2.cni=="canal") {
      metadata = { name = "rke2-canal"; namespace = "kube-system"; };
      spec.valuesContent = ''
        flannel:
          backend: "wireguard"
      '';
    };
    rke2-coredns = {
      metadata = { name = "rke2-coredns"; namespace = "kube-system"; };
      spec.valuesContent = ''
        nodelocal:
          enabled: true
          ipvs: true
      '';
    };
    #  https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx#configuration
    rke2-ingress-nginx = {
      metadata = { name = "rke2-ingress-nginx"; namespace = "kube-system"; };
      spec.valuesContent = ''
        controller:
          config:
            use-forwarded-headers: "true"
      '';
    };
  };
  # https://docs.rke2.io/helm
  # Default includes helm-release CRD: https://docs.rke2.io/helm#using-the-helm-crd
  # which enables Helm Controller to manage charts: https://github.com/k3s-io/helm-controller#helm-controller
}
