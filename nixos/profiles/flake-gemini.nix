{
  inputs,
  config,
  lib,
  ...
}: {
  imports = with inputs.flake-gemini.nixosModules; [
    duckling-proxy
    kineto
    molly-brown
  ];

  services.duckling-proxy = {
    enable = lib.mkDefault false;
    port = lib.mkDefault 1965;
    settings = lib.mkDefault {};
    serverCert = lib.mkDefault config.sops.secrets.duckling-proxy-server-cert.path;
    serverKey = lib.mkDefault config.sops.secrets.duckling-proxy-server-key.path;
  };

  services.kineto = {
    enable = lib.mkDefault false;
    port = lib.mkDefault 8080;
    geminiDomain = lib.mkDefault "gemini://${config.networking.fqdn}";
    # geminiDomain = lib.mkDefault "gemini://gemini.${config.networking.fqdn}";
    extraArgs = lib.mkDefault [];
  };

  # services.molly-brown = {
  #   enable = lib.mkDefault false;
  # };

  networking.firewall.allowedTCPPorts =
    []
    ++ lib.optional config.services.duckling-proxy.enable config.services.duckling-proxy.port
    ++ lib.optional config.services.kineto.enable config.services.kineto.port;

  sops.secrets = lib.mkIf config.services.duckling-proxy.enable {
    duckling-proxy-server-cert = {};
    duckling-proxy-server-key = {};
  };
}
