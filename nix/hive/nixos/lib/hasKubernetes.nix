{ inputs, cell, config, lib, pkgs, }:
let
  getEnabled = kp:
    lib.map (n:
      lib.getAttrByPath (if lib.isString then [ kp ] else kp)
      ++ [ "enable" ] config);
  isServiceEnabled = svc: getEnabled [ "services" svc ];
  isKubernetesServiceEnabled = svc: getEnabled [ "services" "kubernetes" svc ];
  isProgramEnabled = pro: getEnabled [ "programs" pro ];

  # List of options to check
  opt-programs = [ "kubeswitch" ];
  opt-k8s-services = [
    "addonManager"
    "apiserver"
    "controllerManager"
    "flannel"
    "kubelet"
    "pki"
  ];
  opt-services = [ "k3s" ];
in
lib.any (isServiceEnabled opt-services)
++ (isKubernetesServiceEnabled opt-k8s-services)
++ (isProgramEnabled opt-programs)
#config.programs.kubeswitch.enable ||
#config.services.k3s.enable ||
#config.services.kubernetes.kubelet.enable
