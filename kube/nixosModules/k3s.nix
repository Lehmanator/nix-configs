{
  inputs,
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  module-name = "k3s-profile";
  cfg = config.${module-name};
  secret-mgr = "sops";
  config-files = {
    containerd = "/var/lib/rancher/k3s/agent/etc/containerd/config.toml";
    # Go template w/ config.Node passed to template.
    containerd-template = "/var/lib/rancher/k3s/agent/etc/containerd/config.toml.tmpl";
    etcd-server-ca-crt = "/var/lib/rancher/k3s/server/tls/etcd/server-ca.crt";
    etcd-client-crt = "/var/lib/rancher/k3s/server/tls/etcd/client.crt";
    etcd-client-key = "/var/lib/rancher/k3s/server/tls/etcd/client.key";
    manifests = "/var/lib/rancher/k3s/server/manifests";
    service-env = "/etc/systemd/system/k3s.service.env";
    agent-service-env = "/etc/systemd/system/k3s-agent.service.env";
  };
in {
  imports = [];

  options.${module-name} = {
    enable = lib.mkEnableOption module-name;
    isMaster = lib.mkOption {
      type = lib.types.bool;
      description = "Whether this node is a cluster master node.";
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    services.k3s = {
      enable = true;
      package = pkgs.k3s;

      # Init HA cluster using embedded etcd datastore
      clusterInit = cfg.isMaster;

      # File path containing k3s YAML config. Useful when the config is generated.
      configPath = null;

      disableAgent = false;

      # File path containing env vars for configuring the k3s service in the format of an EnvironmentFile. See systemd.exec(5)
      environmentFile = null;
      extraFlags = ''
        --no-deploy traefik --cluster-cidr 10.24.0.0/16
      '';

      role =
        if cfg.isMaster
        then "server"
        else "agent";

      # See: https://rancher.com/docs/k3s/latest/en/installation/installation-requirements/#networking
      serverAddr = lib.mkIf cfg.isMaster ""; # "https://10.0.0.10:6443";
      token = config.sops.secrets.k3s-token.text;
    };

    environment = {
      systemPackages = let
        script-text = ''
          sudo etcdctl version \
            --cacert=/var/lib/rancher/k3s/server/tls/etcd/server-ca.crt \
            --cert=/var/lib/rancher/k3s/server/tls/etcd/client.crt \
            --key=/var/lib/rancher/k3s/server/tls/etcd/client.key
        '';
        script-text1 = with cfg.sops.secrets; ''
          sudo etcdctl version \
          --cacert=${k3s-etcd-server-ca-crt.path} \
          --cert=${k3s-etcd-client-crt.path} \
          --key=${k3s-etcd-client-key.path}
        '';
      in [pkgs.etcd (pkgs.writeShellScript "etcdctl-init" script-text)];
    };

    sops.secrets = {
      k3s-token = {};
      k3s-etcd-server-ca-crt = {
        path = "/var/lib/rancher/k3s/server/tls/etcd/server-ca.crt";
      };
      k3s-etcd-client-crt = {
        path = "/var/lib/rancher/k3s/server/tls/etcd/client.crt";
      };
      k3s-etcd-client-key = {
        path = "/var/lib/rancher/k3s/server/tls/etcd/client.key";
      };
    };
  };
}
