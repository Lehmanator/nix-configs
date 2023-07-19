{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerSocket.enable = true;
    dockerCompat = true;
    #defaultNetwork.settings = {};
    #extraPackages = [];
    networkSocket = {
      enable = true;
      #listenAddress = "0.0.0.0";
      #openFirewall = true;
      #port = 2376;
      #server = "ghostunnel";
      #tls.cacert = <PATH>;
      #tls.cert = <PATH>;
      #tls.key = <PATH>;
    };
  };
}
