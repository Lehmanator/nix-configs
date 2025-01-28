{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  #imports = [ ./k3s-common.nix ];
  sops.secrets.k3s-server-token = {};
  services.k3s = {
    enable = true;
    role = "server";
    tokenFile = config.sops.secrets.k3s-server-token.path;
    clusterInit = true; # Only for bootstrapping node
    #serverAddr = "https://<ip_of_1st_node>:6443";  # For nodes after bootstrap
    extraFlags = toString [
      "--kubelet-arg=v=4"
      "--flannel-backend wireguard-native"
      "--secrets-encryption"
      # --- Hardening ---
      #"--selinux"
      #"--rootless"
      # --- ????? ----
      #"--egress-selector-mode cluster"  # *agent | pod | cluster | disabled  # ???
      #"--enable-pprof"
      #"--flannel-ipv6-masq"
      #"--multi-cluster-cidr"
    ];
  };

  # --- Multi-Node ---
  networking.firewall.allowedTCPPorts = [
    6443 # 6443 for pods<->APIserver
    2379 # for etcd clients (if HA embedded etcd)
    2380 # for etcd peers (if HA embedded etcd)
    10250 # Kubelet metrics
  ];
  networking.firewall.allowedUDPPorts = [
    8472 # for flannel multi-node inter-node networking.
    51820 # for flannel Wireguard IPv4
    51821 # for flannel Wireguard IPv6
  ];

  # --- Config Files ---
  # /etc/rancher/k3s/config.yaml                    - k3s config
  # /etc/rancher/k3s/k3s.yaml                       - k3s kubeconfig
  # /etc/rancher/k3s/registries.yaml                - Private Registry config
  # /var/lib/rancher/credentialprovider/config.yaml - Credential Provider plugin config
  # /var/lib/rancher/k3s or ${HOME}/.rancher/k3s    - State dirs
  environment.systemPackages = [pkgs.k3s];
}
