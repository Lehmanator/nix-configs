{ inputs
, config
, lib
, pkgs
, secretsDir ? "/var/secrets"
, ...
}:
# TODO: Configure encrypted secrets via sops-nix or agenix
{
  imports = [ ];

  # Wiki server
  services.outline =
    let
      name = "outline";
      loginBase = "https://login.${config.networking.domain}/auth/realm/piwc/protocol/openid-connect"; #Keycloak: "auth/realm/piwc/protocol/openid-connect";
    in
    {
      enable = true;
      enableUpdateCheck = true;

      #package = pkgs.outline.overrideAttrs (super: {
      #  # Ignore the domain part in emails that come from OIDC.
      #  #  Might be helpful if you want multiple users w/ different email providers to still land in same team.
      #  #  Note: this effectively makes Outline a single-team instance.
      #  patchPhase = ''
      #    sed -i 's/const domain = parts\.length && parts\[1\];/const domain = "${config.networking.domain}";/g' plugins/oidc/server/auth/oidc.ts
      #  '';
      #};

      concurrency = 1; # How many processes to spawn. Rough est = RAM/512. D:1
      debugOutput = null; #"http";
      defaultLanguage = "en_US";
      #logo = "../../../assets/piwc/logo-256.png"; #"/media/piwc-public/Branding/logo-256.png";
      maximumImportSize = 5120000;

      user = "outline";
      group = "outline";

      rateLimiter = { enable = true; durationWindow = 60; requests = 5000; };

      # --- Endpoint --
      forceHttps = true;
      port = 3000;
      publicUrl = "https://${name}.${config.networking.domain}";

      # --- Secrets ---
      sslCertFile = null; #"${secretsDir}/outline-tls.cert";  # Base64-encoded cert for HTTPS termination.
      sslKeyFile = null; #"${secretsDir}/outline-tls.key";    #   Only required if not using other reverse proxy. See: https://wiki.generaloutline.com/share/dfa77e56-d4d2-4b51-8ff8-84ea6608faa4
      utilsSecretFile = "${secretsDir}/${name}-utils.secret"; #"/var/lib/outline/utils_secret";

      # --- Email ---
      # TODO: Find MS Outlook / MS Exchange host, port, & TLS settings
      # TODO: Pass SMTP server settings into module args
      smtp = {
        host = "piwines.mail.protection.outlook.com";
        fromEmail = "${name}@${config.networking.domain}";
        passwordFile = "${secretsDir}/smtp-user-${name}.passwd";
        port = 465; # TCP Port of the SMTP server
        replyEmail = "internal@${config.networking.domain}";
        secure = true;
        tlsCiphers = ""; # Override SMTP cipher config.
        username = "${name ? "outline" }";
      };

      # --- Storage ---
      storage = {
        accessKey = ""; # TODO: Use sops/agenix secret
        acl = "private"; # ACL setting
        forcePathStyle = true; # Force S3 path style
        region = "xx-xxxx-x"; # AWS S3 region name
        secretKeyFile = "${secretsDir}/${name}-storage-s3-secret.key";
        uploadBucketName = "${name}-piwc-uploads";
        uploadBucketUrl = "s3.${config.networking.domain}"; # URL endpoint of S3-compatible API where uploads should be stored.
        uploadMaxSize = 26214400;
      };

      # --- 3rd-Party ---
      sentryDsn = null; #"";  # Track errors & perf
      sentryTunnel = null; #"";  # Sentry proxy tunnel for bypassing adblockers in the UI
      # TODO: Use encrypted secret.
      googleAnalyticsId = null; # TODO: Use encrypted secret. #"";

      # --- External Resource URIs ---
      cdnUrl = "https://cdn.${config.networking.domain}"; #""; # Paths to JS, CSS, imgs, etc. update to hostname here. D:"",
      # TODO: Use encrypted secret.
      databaseUrl = "local"; #"${name}@pgsql.${config.networking.domain}:5432/${name}"; #"local";  #"pgsql.piwine.com"; # URI to use for the main PostgreSQL database. If this needs to include credentials that shouldn’t be world-readable in the Nix store, set an environment file on the systemd service and override the DATABASE_URL entry. Pass the string local to setup a database on the local server.
      # TODO: Use encrypted secret.
      redisUrl = "local"; #"redis.piwine.com"; # Connection to a redis server. If this needs to include credentials that shouldn’t be world-readable in the Nix store, set an environment file on the systemd service and override the REDIS_URL entry. Pass the string local to setup a local Redis database.

      # --- Authentication -------------------------
      azureAuthentication = { clientSecretFile = "${secretsDir}/${name}-auth-client-azure.secret"; clientId = "${name}-"; resourceAppId = "${name}-"; };
      googleAuthentication = { clientSecretFile = "${secretsDir}/${name}-auth-client-google.secret"; clientId = "${name}-"; };
      oidcAuthentication = { clientSecretFile = "${secretsDir}/${name}-auth-client-oidc.secret"; clientId = "${name}-"; authUrl = "${loginBase}/auth"; tokenUrl = "${loginBase}/token"; userinfoUrl = "${loginBase}/userinfo"; displayName = "PIWC OpenID"; scopes = [ "openid" "profile" "email" ]; usernameClaim = "preferred_username"; }; # Redirect URL: "https://<publicUrl>/auth/oidc.callback"
      slackAuthentication = { secretFile = "${secretsDir}/${name}-auth-client-slack.secret"; clientId = "${name}-"; };
      slackIntegration = { verificationTokenFile = "${secretsDir}/${name}-slack-verification.token"; appId = "${name}-"; messageActions = true; };

    };

  # ClientSecret NixOS: Value: "MS-8Q~T0xr4nV-171fmZvgJS_eaY6NV5zUhp8adj";
  # ClientSecret NixOS:    ID: "4408bfc7-9b88-4908-8c49-afc828cc02bc";

}
