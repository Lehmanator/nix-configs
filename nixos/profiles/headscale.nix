# Configures a Headscale server to coordinate Tailscale VPN mesh networks
#
# To-Dos:
# - TODO: Create secrets with agenix or sops-nix
# - TODO: Pass in proper data for args: host, network, repo
# - TODO: Pass in variable to determine if using local or remote database
# - TODO: Pass in variable to determine OIDC issuer
# - TODO: Import Keycloak server configuration if missing issuer
#
# Other VPNs in Nix:
# - services.toxvpn.enable = true;
# - services.mullvad-vpn = {enable=true; package=pkgs.mullvad-vpn;};
# - services.mozillavpn.enable = true;
# - services.expressvpn.enable = true;
# - services.openvpn.servers = {};
{
  inputs,
  config,
  lib,
  pkgs,
  dbType ? "sqlite3",
  extraDomains ? ["lehman.run" "samlehman.me" "samlehman.dev"],
  ...
}: let
  domainList = with lib.lists;
    unique (builtins.concatLists extraDomains (forEach [
        config.networking.domain
        config.networking.fqdn
        config.networking.hostName
        "lan"
        "wan"
        "local"
        "internal"
        "home"
        "lehman.run"
        "samlehman.me"
        "samlehman.dev"
      ]
      (i: [i "${config.networking.hostName}.${i}" "headscale.${i}"])));
  users = with lib.lists;
    unique (builtins.concatLists
      (forEach ["publicSam" "slehman"] (i: [i "${i}@gmail.com"])) [
        (hosts.users.primary ? "sam")
        "sam"
        "sam.lehman"
        "samlehman"
        "samuel.lehman"
      ]);
in {
  imports = [
    (inputs.self + /nixos/profiles/wireguard.nix)
    # (inputs.self + /nixos/profiles/keycloak.nix)
    # (inputs.self + /nixos/profiles/postgresql.nix)
  ];
  services.headscale = {
    enable = true; # Enable Headscale server
    package = pkgs.headscale; # Headscale server's package
    user = "headscale"; # Headscale server's Unix user  name
    group = "headscale"; # Headscale server's Unix group name
    address = "127.0.0.1"; # Headscale server's listening address
    port = 8080; # Headscale server's listening port
    settings = {
      server_url = "https://headscale.${config.networking.fqdn}:443";
      acl_policy_path = null;
      db_name = "headscale";
      db_user = "headscale";
      db_password_file = config.sops.secrets.headscale-database-password.path;
      #db_password_file = "${secretDir}/headscale-db-password.key";
      db_path = "/var/lib/headscale/db.sqlite";
      db_host =
        if dbType == "sqlite3"
        then null
        else "${dbType}.${config.networking.domain}";
      db_port =
        if dbType == "pgsql"
        then 5432
        else if dbType == "mysql"
        then 3306
        else null;
      db_type = dbType;
      derp = {
        auto_update_enable = true;
        update_frequency = "15m";
        paths = [];
        urls = ["https://controlplane.tailscale.com/derpmap/default"];
      };
      dns_config = {
        domains = domainList;
        magic_dns = true;
        override_local_dns = false;
        nameservers = ["1.1.1.1"];
      };
      ephemeral_node_inactivity_timeout = "30m";
      log.format = "text"; # (text|json)
      log.level = "info"; # (info|debug)
      #noise.private_key_path = "${secretDir}/headscale-noise-privatekey.key"; # "/var/lib/headscale/private.key";
      noise.private_key_path = config.sops.secrets.headscale-noise-privkey.path;
      oidc = {
        allowed_domains = domainList;
        allowed_users = with lib.lists; builtins.concatLists (forEach users (u: builtins.concatLists (forEach domains (d: [u "${u}@${d}"]))));
        extra_params = {domain_hint = config.networking.domain;};
        issuer = "https://login.${config.networking.domain}/auth/realms/master"; # Keycloak
        scope = ["openid" "profile" "email"];
        strip_email_domain = true;
        client_secret_path = config.sops.secrets.headscale-oidc-client-secret.path;
        client_id = "headscale-${config.networking.domain}-${config.networking.hostName}";
        #client_id = config.sops.secrets.headscale-oidc-client-id.path;
        #client_secret_path = "${secretDir}/headscale-oidc-client-secret.key"; # Path to OIDC client secret file. Expands env vars in format ${VAR}
      };
      tls_cert_path = config.sops.secrets.headscale-tls-cert.path;
      tls_key_path = config.sops.secrets.headscale-tls-key.path;
      #tls_cert_path = "${secretDir}-headscale-tls.cert";
      #tls_key_path = "${secretDir}-headscale-tls.pem";
      tls_letsencrypt_challenge_type = "HTTP-01"; # ( HTTP-01 | TLS-ALPN-01 )
      tls_letsencrypt_hostName = "https://headscale.${config.networking.fqdn}";
      tls_letsencrypt_listen = ":http";
    };
  };

  #services.tailscale = {
  #  enable = true;
  #  interfaceName = "tailscale0";
  #  package = pkgs.tailscale;
  #  permitCertUid = null;          # Username/UserID of the user allowed to fetch Tailscale TLS certificates for the node.
  #  port = 41641;
  #  useRoutingFeatures = "both";   # Enable subnet routers & exit nodes.  (none|client|server|both)
  #};                               #  Need to call `sudo tailscale up` w/ flags `--advertise-exit-node` & `--exit-node`

  sops.secrets = {
    headscale-database-password = {};
    headscale-noise-privkey = {};
    heaadscale-oidc-client-id = {};
    heaadscale-oidc-client-secret = {};
    headscale-tls-key = {};
    headscale-tls-cert = {};
  };
}
