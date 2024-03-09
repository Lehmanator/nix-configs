{
  self,
  system,
  inputs,
  host,
  config, lib, pkgs,
  ...
}:
let
in
{
  imports = [

  ];

  services.postgresql.enable = true;
  services.postgresql.enableJIT = lib.mkDefault false;   # default: false
  services.postgresql.enableJIT = lib.mkDefault true;    # default: false   # Listen on all network interfaces (vs. unix domain socket & TCP connections to localhost)
  #services.postgresql.extraPlugins = with pkgs.postgresql_11.pkgs; [ postgis pg_repack ];

  # Mapping from system users to database users
  #   General Form: <MapName> <SystemUsername> <DatabaseUsername>
  #services.postgresql.identMap = ''
  #  superUser root superuser
  #  primaryUser ${host.users.primary} ${host.users.primary}
  #'';
  #services.postgresql.initdbArgs = [ "--data-checksums" "--allow-group-access" ];
  #services.postgresql.initialScript = null;  # File path containing SQL statements to execute on first startup
  #  logLinePrefix = "[%p] ";  # "%m [%p] ";  # Includes timestamp (unnecessary in journal)

  services.postgresql.port = 5432;
  #services.postgresql.recoveryConfig = null;  # Contents of recovery.conf file.

  services.postgresql.settings = {
    log_connections = true;
    #log_statement = "all";
    #logging_collector = true;
    #log_disconnections = false;
    #log_destination = lib.mkDefault "syslog";
  };

  # Databases to automatically create
  services.postgresql.ensureDatabases = [
    "homeassistant"
    "nextcloud"
    "piwc-website"
    "piwc-activedirectory"
    "piwc-quickbooks"
    "piwc-facts"
    "piwc-square"
    "piwc-devices"
    "piwc-employees"
    "piwc-licenses"
  ];

  # Users to automatically create
  services.postgresql.ensureUsers = [
    { name = host.user.primary;
      ensureClauses = {
        createdb = true;
        createrole = true;
        login = true;
        replication = false;
        superuser = false;
      };
      ensurePermissions = {
        "DATABASE nextcloud" = "ALL PRIVILEGES";
      };
    }
    { name = "nextcloud";
      ensureClauses = {
        bypassrls = false;
        createdb = true;
        createrole = true;
        #inherit = null;
        login = true;
        replication = false;
        superuser = true;
      };
      ensurePermissions = {
        "DATABASE nextcloud" = "ALL PRIVILEGES";
      };
    }
    { name = "superuser";
      ensurePermissions = {
        "ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
      };
    }
  ];

  services.postgresqlBackup = {
    enable = true;
    backupAll = true;
    compression = "zstd";  # default: gzip
    compressionLevel = 6;
    #databases = [ ];
    location = "/var/backup/postgresql";
    pgdumpOptions = [ "-C" ];
  };

}
