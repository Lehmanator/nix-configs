{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  # https://2019.www.torproject.org/docs/tor-manual.html.en#HiddenServiceDir
  services.tor = {
    enable = true;
    enableGeoIP = true;
    openFirewall = false;
    controlSocket.enable = true;

    client = {
      enable = true;
      dns.enable = true;
      onionServices = {
        ssh = {
          # TODO: Secrets via sops-nix/agenix
          clientAuthorizations = ["/run/keys/tor-client-${user}.prv.x25519"];
        };
      };
      socksListenAddress = {
        IsolateDestAddr = true;
        addr = "127.0.0.1";
        port = 9050;
      };
      transparentProxy.enable = true;
    };

    relay = {
      enable = false;
      role = "private-bridge"; # exit | relay | bridge | private-bridge
      onionServices = {
        ssh = {
          authorizedClients = [];
          authorizeClient = {
            authType = "";
            clientNames = [];
          };
          map = "";
          path = "";
          secretKey = config.secrets.tor-service-secretKey-ssh.path;
          version = 3;
          settings = {
            HiddenServiceAllowUnknownPorts = false;
            HiddenServiceDirGroupReadable = false;
            HiddenServiceExportCircuitID = false;
            HiddenServiceMaxStreams = false;
            HiddenServiceMaxStreamsCloseCircuit = false;
            HiddenServiceNumIntroductionPoints = false;
            HiddenServiceSingleHopMode = false;
            RendPostPeriod = false;
          };
        };
      };
    };

    torsocks = {
      enable = true;
      allowInbound = false;
      fasterServer = "127.0.0.1:9063";
      onionAddrRange = "127.42.42.0/24";
      server = "127.0.0.1:9050";
      socks5Password = null;
      socks5Username = user;
    };

    settings = {
      AccountingMax = null;
      AccountingStart = null;
      Address = null;
      AssumeReachable = null;
      AuthDirHasIPv6Connectivity = null;
      # ...
    };

  };

  sops.secrets.tor-service-secretKey-ssh = {};
  sops.secrets.tor-torsocks-username = {};
  sops.secrets.tor-torsocks-password = {};
}
