{ inputs, self
, config, lib, pkgs
, ...
}:
{

  imports = [
    #./azure-activedirectory.nix # ???
    #./azure-kubernetes.nix      # ???
    #./common
  ];

  home.packages = [
    pkgs.azure-cli
    pkgs.kubelogin
  ];

}
