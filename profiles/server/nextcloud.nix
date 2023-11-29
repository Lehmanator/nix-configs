{ inputs
, config
, lib
, pkgs
, domain ? "samlehman.me"
, user
, ...
}:
{
  #imports = [ ./minio.nix ./redis.nix ];
  services.nextcloud = {
    enable = true;
    enableImagemagick = true;
    #package = pkgs.nextcloud;
    #phpPackage = "pkgs.php";
    appstoreEnable = true;
    autoUpdateApps.enable = true;
    caching.redis = true;
    configureRedis = true; #config.services.nextcloud.notify_push.enable;
    database.createLocally = false;
    fastcgiTimeout = 120;
    globalProfiles = true;
    home = "/var/lib/nextcloud";
    hostName = "nextcloud.${domain}";
    https = true;
    logLevel = 2;
    logType = "systemd"; # Requires php-systemd extension
    maxUploadSize = "4096M";
    secretFile = null; # Secret options which will be appended to Nextcloud’s config.php file (written as JSON, in the same form as the services.nextcloud.extraOptions option), for example {"redis":{"password":"secret"}}.
    #skeletonDirectory = "/etc/skel"; #The directory where the skeleton files are located. These files will be copied to the data directory of new users. Leave empty to not copy any skeleton files.
    webfinger = true;
    config = {
      adminuser = user;
      dbhost = "";
      dbname = "nextcloud";
      dbpassFile = config.sops.secrets.nextcloud-database-password.path;
      dbport = 111;
      dbtableprefix = "";
      dbtype = "pgsql";
      dbuser = "nextcloud";
      defaultPhoneRegion = "US";
      extraTrustedDomains = [
        # Trusted domains from which the Nextcloud installation will be accessible. You don’t need to add services.nextcloud.hostname here.
        config.networking.fqdn
        config.networking.hostName
        "samlehman.me"
        "samlehman.dev"
        "redstone.pw"
      ];
      objectstore.s3 = {
        enable = true;
        autocreate = true;
        bucket = "nextcloud";
        hostname = "minio.${domain}";
        #key = "";
        port = "";
        region = "us-east";
        secretFile = config.sops.secrets.nextcloud-objectstore-secret.path;
        sseCKeyFile = config.sops.secrets.nextcloud-objectstore-sseckey.path;
        usePathStyle = true;
        useSsl = true;
      };
      overwriteProtocol = "https";
      trustedProxies = [ ];
    };
    extraAppsEnable = true;
    extraApps = { };
    extraOptions = {
      redis = {
        host = "/run/redis/redis.sock";
        port = 0;
        dbindex = 0;
        password = config.sops.secrets.nextcloud-redis-password.path; # "secret";
        timeout = 1.5;
      };
    };
    # Additional PHP extensions to use for Nextcloud. By default, only extensions necessary for a vanilla Nextcloud installation are enabled, but you may choose from the list of available extensions and add further ones. This is sometimes necessary to be able to install a certain Nextcloud app that has additional requirements.
    #phpExtraExtensions = all: []; # all: [ all.pdlib all.bz2 ]
    nginx = {
      hstsMaxAge = 15552000;
      recommendedHttpHeaders = true;
    };
    notify_push = {
      enable = true;
      #package = pkgs.nextcloud-notify_push;
      bendDomainToLocalhost = true; # Whether to add an entry to /etc/hosts for the configured nextcloud domain to point to localhost and add localhost to nextcloud’s trusted_proxies config option. This is useful when nextcloud’s domain is not a static IP address and when the reverse proxy cannot be bypassed because the backend connection is done via unix socket.
      #dbhost = "";
      #dbname = "";
      #dbpassFile = config.sops.secrets.nextcloud-notifypush-database-password.path; #"";
      #dbport = "";
      #dbtableprefix = "";
      #dbtype = "pgsql";
      #dbuser = "notifypush";
      logLevel = "error";
      socketPath = "/run/nextcloud-notify_push/sock"; # Socket path to use for notify_push
    };
    # Options for PHP’s php.ini file for nextcloud. Please note that this option is additive on purpose while the attribute values inside the default are option defaults.
    phpOptions = {
      catch_workers_output = "yes";
      display_errors = "stderr";
      error_reporting = "E_ALL & ~E_DEPRECATED & ~E_STRICT";
      expose_php = "Off";
      "opcache.enable_cli" = "1";
      "opcache.fast_shutdown" = "1";
      "opcache.interned_strings_buffer" = "8";
      "opcache.max_accelerated_files" = "10000";
      "opcache.memory_consumption" = "128";
      "opcache.revalidate_freq" = "1";
      "openssl.cafile" = "/etc/ssl/certs/ca-certificates.crt";
      short_open_tag = "Off";
    };
    # Options for Nextcloud’s PHP pool. See the documentation on php-fpm.conf for details on configuration directives.
    #poolConfig = null; #'''
    #''';
    # Options for nextcloud’s PHP pool. See the documentation on php-fpm.conf for details on configuration directives.
    poolSettings = {
      pm = "dynamic";
      "pm.max_children" = "32";
      "pm.max_requests" = "500";
      "pm.max_spare_servers" = "4";
      "pm.min_spare_servers" = "2";
      "pm.start_servers" = "2";
    };
  };

  sops.secrets = {
    nextcloud-database-password = { };
    nextcloud-notifypush-database-password = { };
    nextcloud-objectstore-secret = { };
    nextcloud-objectstore-sseckey = { };
    nextcloud-redis-password = { };
  };
}
