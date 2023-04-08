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
{ self, inputs, config, lib, pkgs,
  host, network, repo,
  system      ? "x86_64-linux",
  userPrimary ? "sam",
  extraDomains ? [
    "redstone.pw"
    "lehman.run"
    "samlehman.me"
    "samlehman.dev"
    "samlehman.cloud"  "samlehman.biz"   "samlehman.info"
  ],
  ...
}:
let
  inherit (config.networking) fqdn domain hostName;
  secretDir = if repo ? "secrets" then repo.secrets else "../../secrets";
  domainList = with lib.lists; unique (builtins.concatLists extraDomains (forEach [ domain fqdn host
      "lan" "wan" "local" "internal" "home"
      "redstone.pw"
      "lehman.run"
      "samlehman.me" "samlehman.dev" "samlehman.cloud"
      "samlehman.biz" "samlehman.info"
      "pi.wine" "piwine.com" "pi.local"
    ] (i: [i "${hostName}.${i}" "headscale.${i}"])));
  users = with lib.lists; unique (builtins.concatLists
  (forEach [ "samlehman617" "publicSam" "slehman" "14lehmans" ] (i: [i "${i}@gmail.com" "${i}@piwine.com"])) [
    (hosts.users.primary ? "sam")
    "sam" "sam.lehman" "samlehman" "samuel.lehman"
    "red" "redstone"  "redstone-ssb" "redstonessb" 
  ]);
in
{
  imports = [
    # TODO: Configure agenix / sops-nix secrets
    inputs.agenix.nixosModules.age
    #../auth/keycloak.nix
    #../database/postgresql.nix
    ../network/wireguard/default.nix
  ];

  services.headscale.enable  = true;           # Enable Headscale server
  services.headscale.package = pkgs.headscale; # Headscale server's package
  services.headscale.user    = "headscale";    # Headscale server's Unix user  name
  services.headscale.group   = "headscale";    # Headscale server's Unix group name
  services.headscale.address = "127.0.0.1";    # Headscale server's listening address
  services.headscale.port    = 8080;           # Headscale server's listening port

  services.headscale.settings = let
    sprefix = if host ? "dirs.secrets" then "${host.dirs.secrets}/headscale" else "/run/secrets/headscale";
    dbType = "sqlite3";  # "pgsql";
  in {
    server_url = "https://headscale.${fqdn}:443";

    acl_policy_path = null;

    db_name          = "headscale";
    db_user          = "headscale";
    db_password_file = "${sprefix}-db-password.key";
    db_path          = "/var/lib/headscale/db.sqlite";
    db_host          = if dbType == "pgsql" then "pgsql.${domain}" else null;
    db_port          = if dbType == "pgsql" then 5432 else null;
    db_type          = dbType;

    derp.update_frequency   = "15m";
    derp.paths              = [ ];
    derp.auto_update_enable = true;
    derp.urls               = [ "https://controlplane.tailscale.com/derpmap/default" ];

    dns_config = { domains = domainList;
                 magic_dns = true;
        override_local_dns = false;
               nameservers = [ "1.1.1.1" ];  };

    ephemeral_node_inactivity_timeout = "30m";
    log.format = "text";   # (text|json)
    log.level  = "info";   # (info|debug)
    noise.private_key_path = "${sprefix}-noise-privatekey.key";  # "/var/lib/headscale/private.key";

    oidc.allowed_domains    = domainList;
    oidc.allowed_users      = with lib.lists; builtins.concatLists (forEach users (u: builtins.concatLists (forEach domains (d: [u "${u}@${d}"]))));
    oidc.extra_params       = { domain_hint = domain; };
    oidc.issuer             = "https://login.${domain}/auth/realms/master";  # Keycloak
    oidc.scope              = ["openid" "profile" "email"];
    oidc.strip_email_domain = true;
    oidc.client_id          = "headscale-${domain}-${hostName}";
    oidc.client_secret_path = "${sprefix}-oidc-client-secret.key";  # Path to OIDC client secret file. Expands env vars in format ${VAR}

    tls_cert_path                  = "${sprefix}-tls-headscale.${fqdn}.cert";
    tls_key_path                   = "${sprefix}-tls-headscale.${fqdn}.pem";
    tls_letsencrypt_challenge_type = "HTTP-01";  # ( HTTP-01 | TLS-ALPN-01 )
    tls_letsencrypt_hostName       = "https://headscale.${fqdn}";
    tls_letsencrypt_listen         = ":http";

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
