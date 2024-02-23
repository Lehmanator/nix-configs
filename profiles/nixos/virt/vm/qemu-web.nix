{ inputs , config, lib, pkgs , ... }:
{
  # See: https://nixos.wiki/wiki/Libvirt
  # QEMU web clients:
  # - https://cgit.freedesktop.org/spice/spice-html5/
  # - https://github.com/eyeos/spice-web-client/
  # Access QEMU VMs thru web browser
  # Since libvirt doesn't support websockets on its own, we'll need to add websockify to your configuration.nix
  services.networking.websockify = {
    enable = false;
    sslCert = "/https-cert.pem";
    sslKey = "/https-key.pem";
    portMap = {
      "5959" = 5900;
    };
  };
  services.nginx = {
    enable = config.services.networking.websockify.enable;
    virtualHosts."qemu-web-client.fw.local" = {
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
      sslCertificate = "/https-cert.pem";
      sslCertificateKey = "/https-key.pem";
      listen = [ { addr = "*"; port = 45000; ssl = true; } ];
    };
  };
}
