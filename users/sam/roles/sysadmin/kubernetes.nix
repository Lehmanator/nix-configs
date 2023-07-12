{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # TODO: Separate into Kubernetes developer & administrator
  home.packages = [
    pkgs.kubelogin
    pkgs.kubeadm
    pkgs.kubectl
    pkgs.k9s
  ];

}
