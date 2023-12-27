{ self, inputs, outputs, config, lib, pkgs,
  host, repo, user, network, machine,
  ...
}:
# TODO: Add impermanence
# TODO: Create lib to automatically create for each service:
# - TODO: Impermanence persistence for data dirs
# - TODO: DNS entries
# - TODO: Theme config (nix-colors | stylix)
# - TODO: Service Accounts for backend programs
#   - TODO: Unix:      user, group, 
#   - TODO: Auth:      LDAP, Keycloak, Hashicorp Vault
#     - Fields: client_id, client_secret, service_account_name, service_account_password
#   - TODO: Database:  mysql, postgresql, mongodb, sqlite3
#     - Fields: username, database name, password file secret
#   - TODO: Cache:     redis, memcached
#     - Fields: username, database name, password file secret
#   - TODO: Storage:   minio, host filesystem, 
#     - Fields: bucket, encryption_key
#   - TODO: Reverse Proxy: NGINX, Apache, Traefik, 
#     - Fields: Virtual host, SSL certs, ingress, port-mapping,
#   - TODO: Mailing:   maingun, 
let
  program = "firefly";
  hostname = "${program}.${config.networking.hostName}";
  fqdn     = "${program}.${config.networking.fqdn}";
  dataDir = "/var/lib/${program}";
  #secretDir = "${repo.base}/hosts/${config.networking.hostName}/secrets";
  secrets = {
    repo = "${repo.secrets}/${config.networking.hostName}";
    host = "/run/secrets/${program}";
  };
  secret = "${secrets.host}/${program}-appkey.key";
in
{
  imports = [
    inputs.firefly.nixosModules.firefly-iii
    inputs.agenix.nixosModules.age
    #inputs.impermanence.nixosModules.impermanence
  ];
  nix.settings.substituters = [ "https://timhae-firefly.cachix.org/" ];
  nix.settings.trusted-public-keys = [ "timhae-firefly.cachix.org-1:TMexYUvP5SKkeKG11WDbYUVLh/4dqvCqSE/c028sqis=" ];

  age.secrets."${program}-appkey" = {
    file = "${secrets.repo}/${program}-appkey.age";
    mode = "770";
    owner = "firefly-iii";
    group = "nginx";
  };

  services.firefly-iii = {
    enable = true;
    hostname = fqdn;
    appURL = "https://${fqdn}";
    appKeyFile = config.age.secrets."${program}-appkey".path;
    dataDir = dataDir;       # TODO: Persist with impermanence
    group = "nginx";
    nginx = {
      serverAliases = [ program hostname fqdn "${program}.local" "${program}.lan" ];
      forceSSL   = lib.mkDefault true;
      enableACME = lib.mkDefault true;
    };
    poolConfig = {
      "pm" = "dynamic";
      "pm.max_children" = 32;
      "pm.start_servers" = 2;
      "pm.min_spare_servers" = 2;
      "pm.max_spare_servers" = 4;
      "pm.max_requests" = 500;
    };
    config = {
      MAILGUN_SECRET = { _secret = config.age.secrets."${program}-serviceaccount-mailgun".path; };
    };
    database = rec {
      type = lib.mkDefault "pgsql";
      host = if createLocally then "localhost" else "${type}.${config.networking.domain}";
      port = if type == "pgsql" then 5432 else 3306;
      name = program;
      passwordFile = config.age.secrets."${program}-serviceaccount-${type}".path;
      createLocally = lib.mkDefault false;
    };
  };

}
