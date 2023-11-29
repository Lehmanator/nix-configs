{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  #imports = [ ./wireguard.nix ]; Load generic base wireguard config
  networking.wq-quick.interfaces.wg0 = {
    address = [ ];
    peers = [{
      allowedIPs = [ "" /32 ];
      endpoint = ":"; # TODO: Point at Kubernetes cluster / Azure Kubernetes Service?
      publicKey = ""; # TODO: Use `agenix` / `sops-nix` to generate?
    }];
  };
}
