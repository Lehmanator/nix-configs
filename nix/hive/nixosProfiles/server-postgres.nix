{ inputs, config, lib, pkgs, user, ... }: {
  services.postgresql = {
    enable = true;
    enableJIT = lib.mkDefault
      false; # default: false   # Listen on all network interfaces (vs. unix domain socket & TCP connections to localhost)
    #extraPlugins = with pkgs.postgresql_11.pkgs; [ postgis pg_repack ];

    # Mapping from system users to database users
    #   General Form: <MapName> <SystemUsername> <DatabaseUsername>
    #identMap = ''
    #  superUser root superuser
    #  primaryUser ${user} ${user}
    #'';
    #initdbArgs = [ "--data-checksums" "--allow-group-access" ];
    #initialScript = null;  # File path containing SQL statements to execute on first startup
    #  logLinePrefix = "[%p] ";  # "%m [%p] ";  # Includes timestamp (unnecessary in journal)

    port = 5432;
    #recoveryConfig = null;  # Contents of recovery.conf file.

    settings = {
      log_connections = true;
      #log_statement = "all";
      #logging_collector = true;
      #log_disconnections = false;
      #log_destination = lib.mkDefault "syslog";
    };

    # Databases to automatically create
    ensureDatabases = [ "homeassistant" "nextcloud" ];

    # Users to automatically create
    ensureUsers = [
      {
        name = user;
        ensureClauses = {
          createdb = true;
          createrole = true;
          login = true;
          replication = false;
          superuser = false;
        };
        ensurePermissions = { "DATABASE nextcloud" = "ALL PRIVILEGES"; };
      }
      {
        name = "nextcloud";
        ensureClauses = {
          bypassrls = false;
          createdb = true;
          createrole = true;
          #inherit = null;
          login = true;
          replication = false;
          superuser = true;
        };
        ensurePermissions = { "DATABASE nextcloud" = "ALL PRIVILEGES"; };
      }
      {
        name = "superuser";
        ensurePermissions = {
          "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
        };
      }
    ];
  };

  services.postgresqlBackup = {
    enable = true;
    backupAll = true;
    compression = "zstd"; # default: gzip
    compressionLevel = 6;
    #databases = [ ];
    location = "/var/backup/postgresql";
    pgdumpOptions = [ "-C" ];
  };
}
