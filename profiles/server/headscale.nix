# Configures a Headscale server to coordinate Tailscale VPN mesh networks
#
# To-Dos:
# - TODO: Create secrets with agenix or sops-nix
# - TODO: Pass in proper data for args: host, network, repo
# - TODO: Pass in variable to determine if using local or remote database
# - TODO: Pass in variable to determine OIDC issuer
# - TODO: Import Keycloak server configuration if missing issuer
#
#
#
# Other VPNs in Nix:
# - services.toxvpn.enable = true;
# - services.mullvad-vpn = {enable=true; package=pkgs.mullvad-vpn;};
# - services.mozillavpn.enable = true;
# - services.expressvpn.enable = true;
# - services.openvpn.servers = {};
{ inputs
, config
, lib
, pkgs
, dbType ? "sqlite3"    # "pgsql"
, secretType ? "agenix"
, user ? "sam"
, extraDomains ? [
    "redstone.pw"
    "lehman.run"
    "samlehman.me"
    "samlehman.dev"
    "samlehman.cloud"
    "samlehman.biz"
    "samlehman.info"
  ]
, ...
}:
let
  secretDir =
    if secretType == "agenix"
    then "/run/agenix"
    else "/run/secrets";
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
      "redstone.pw"
      "lehman.run"
      "samlehman.me"
      "samlehman.dev"
      "samlehman.cloud"
      "samlehman.biz"
      "samlehman.info"
      "pi.wine"
      "piwine.com"
      "pi.local"
    ]
      (i: [ i "${config.networking.hostName}.${i}" "headscale.${i}" ])));
  users = with lib.lists;
    unique (builtins.concatLists
      (forEach [ "samlehman617" "publicSam" "slehman" "14lehmans" ] (i: [ i "${i}@gmail.com" "${i}@piwine.com" ])) [
      (hosts.users.primary ? "sam")
      "sam"
      "sam.lehman"
      "samlehman"
      "samuel.lehman"
      "red"
      "redstone"
      "redstone-ssb"
      "redstonessb"
    ]);
in
{
  imports = lib.lists.optional (secretType == "agenix") inputs.agenix.nixosModules.age ++
    lib.lists.optional (secretType == "sops") inputs.sops-nix.nixosModules.sops-nix ++ [
    # TODO: Configure agenix / sops-nix secrets
    #../auth/keycloak.nix
    #../database/postgresql.nix
    ../network/wireguard/default.nix
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
      db_password_file = "${secretDir}/headscale-db-password.key";
      db_path = "/var/lib/headscale/db.sqlite";
      db_host = if dbType == "sqlite3" then null else "${dbType}.${config.networking.domain}";
      db_port = if dbType == "pgsql" then 5432 else if dbType == "mysql" then 3306 else null;
      db_type = dbType;

      derp = {
        auto_update_enable = true;
        update_frequency = "15m";
        paths = [ ];
        urls = [ "https://controlplane.tailscale.com/derpmap/default" ];
      };

      dns_config = {
        domains = domainList;
        magic_dns = true;
        override_local_dns = false;
        nameservers = [ "1.1.1.1" ];
      };

      ephemeral_node_inactivity_timeout = "30m";
      log.format = "text"; # (text|json)
      log.level = "info"; # (info|debug)
      noise.private_key_path = "${secretDir}/headscale-noise-privatekey.key"; # "/var/lib/headscale/private.key";

      oidc = {
        allowed_domains = domainList;
        allowed_users = with lib.lists; builtins.concatLists (forEach users (u: builtins.concatLists (forEach domains (d: [ u "${u}@${d}" ]))));
        extra_params = { domain_hint = config.networking.domain; };
        issuer = "https://login.${config.networking.domain}/auth/realms/master"; # Keycloak
        scope = [ "openid" "profile" "email" ];
        strip_email_domain = true;
        client_id = "headscale-${config.networking.domain}-${config.networking.hostName}";
        client_secret_path = "${secretDir}/headscale-oidc-client-secret.key"; # Path to OIDC client secret file. Expands env vars in format ${VAR}
      };

      tls_cert_path = "${secretDir}-headscale-tls.cert";
      tls_key_path = "${secretDir}-headscale-tls.pem";
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
}
