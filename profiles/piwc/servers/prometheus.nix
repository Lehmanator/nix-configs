{ inputs
, config
, lib
, pkgs
, env ? "prod"
, secretsDir ? "/run/secrets"
, ...
}:
let
  baseName = "prometheus";
in
{
  imports = [
  ];

  services.prometheus.scrapeConfigs.main.azure_sd_configs = let cfgName = "main"; in {
    authentication_method = null; # null | "OAuth" | "ManagedIdentity"
    client_id = "${baseName}-${cfgName}-${env}";
    client_secret = ""; #File: "${idPrefix}-auth-client.secret";
    environment = null; #"AzurePublicCloud";
    follow_redirects = null;  # true;  # HTTP requests follow HTTP 3xx redirects
    port = null; # 80;
    proxy_url = null; #"";
    refresh_interval = null; # "300s";
    subscription_id = "";
    tenant_id = null; #"";
    tls_config = {
      ca_file = "${secretsDir}/tls/${cfgName}-${config.networking.domain}.cacert";
      cert_file = "${secretsDir}/tls/${cfgName}-${config.networking.domain}.cert";
      key_file = "${secretsDir}/tls/${cfgName}-${config.networking.domain}.key";
      server_name = "${cfgName ? "prometheus"}"; #"${cfgName ? "prometheus"}.${config.networking.domain}";
      insecure_skip_verify = null;  #false; # Disable validation of the server certificate.
    };
  };
  #services.prometheus.scrapeConfigs.*.azure_sd_configs = {};

}
