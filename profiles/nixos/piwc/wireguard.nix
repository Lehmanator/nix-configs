{
  self,
  system,
  inputs,
  host, userPrimary,
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [
    # Load generic base wireguard config
    ./wireguard.nix
  ];

  networking.wq-quick.interfaces.wg0.address = [];
  networking.wq-quick.interfaces.wg0.peers = [{
    allowedIPs = [""/32 ];
    endpoint = ":";
    publicKey = "";
  }];
}
