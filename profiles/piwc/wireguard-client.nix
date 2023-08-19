{ inputs, self
, config, lib, pkgs
, host, userPrimary
, system
, ...
}:
{
  imports = [
    # Load generic base wireguard config
    #./wireguard.nix
  ];

  networking.wq-quick.interfaces.wg0 = {
    address = [
    ];
    peers = [{
      allowedIPs = [
        ""/32
      ];
      endpoint = ":";  # TODO: Point at Kubernetes cluster / Azure Kubernetes Service?
      publicKey = "";  # TODO: Use `agenix` / `sops-nix` to generate?
    }];
  };
}
