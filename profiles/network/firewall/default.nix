{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./iptables.nix
    ./nftables.nix
    #./ufw.nix
  ];

}
