{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    (inputs.self + /nixos/profiles/qemu.nix)
  ];

  # See: https://nixos.wiki/wiki/Libvirt
  # QEMU web clients:
  # - https://cgit.freedesktop.org/spice/spice-html5/
  # - https://github.com/eyeos/spice-web-client/
  # Access QEMU VMs thru web browser
  # Since libvirt doesn't support websockets on its own, we'll need to add websockify to your configuration.nix
  services.networking.websockify = {
    enable = false;
    sslCert = config.sops.secrets.websockify-ssl-cert.path;
    sslKey = config.sops.secrets.websockify-ssl-key.path;
    portMap = {
      "5959" = 5900;
    };
  };
  services.nginx = {
    enable = config.services.networking.websockify.enable;
    virtualHosts."qemu-web-client.${config.networking.hostName}.local" = {
      forceSSL = true;
      root = "/var/www/";
      locations."/spice/" = {
        index = "index.html index.htm";
      };
      locations."/websockify/" = {
        proxyWebsockets = true;
        proxyPass = "https://127.0.0.1:5959";
        extraConfig = ''
          proxy_read_timeout 61s;
          proxy_buffering off;
        '';
      };
      sslCertificate = config.sops.secrets.websockify-ssl-cert.path;
      sslCertificateKey = config.sops.secrets.websockify-ssl-key.path;
      listen = [
        {
          addr = "*";
          port = 45000;
          ssl = true;
        }
      ];
    };
  };

  security.acme.certs = {
    "websockify.${config.networking.domain}" = {
      email = "acme@samlehman.dev";
      webroot = "/var/lib/acme/acme-challenge/";
    };
  };

  sops.secrets = lib.mkIf config.services.networking.websockify.enable {
    websockify-ssl-cert = {};
    websockify-ssl-key = {};
  };
}
