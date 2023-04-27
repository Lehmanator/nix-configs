{ self, inputs, config, lib, pkgs,
  host, user, repo, network, machine,
  settings,
  ...
}:
# https://nixos.wiki/wiki/Matrix

let
  hostname = host.domain or "redstone.pw";
  serverType = if
    config.services.matrix-synapse.enable then "matrix-synapse.service" else if
    config.services.matrix-conduit.enable then "matrix-conduit.service" else "matrix-dendrite.service";

  appservices = [ "discord" "irc" ];

  database = {
    host = "localhost";
    port = 5432;
    users = {
      "${hostname}-appservice-irc" = { name = "matrix-${hostname}-appservice-irc-${hostname}"; password = ""; };
    };
  };
  dbConnectionString = {
    type ? "postgres",
    user ? "matrix",
    password,
    port ? 5432,  # TODO: Determine default based on DB type
    database ? "matrix-appservice",
  }: "${type}://${user}:${password}@${host}:${port}/${database}";

in
with settings;
{
  imports = [
    inputs.agenix.nixosModules.age
  ];

  environment.systemPackages = [
    pkgs.matrix-appservice-slack
    pkgs.mautrix-googlechat
    pkgs.mautrix-signal
    pkgs.mautrix-whatsapp
  ];

  # TODO: Define secrets here
  # TODO: Convert `hostname` to `matrix_hostname`

  # Single Discord server
  services.matrix-appservice-discord = {
    enable = false;
    # File containing environment variables to be passed to the matrix-appservice-discord service, in which secret tokens can be specified securely by defining values for APPSERVICE_DISCORD_AUTH_CLIENT_I_D and APPSERVICE_DISCORD_AUTH_BOT_TOKEN
    environmentFile = null;

    # The user_id localpart to assign to the AS.
    localpart = null;

    port = 9005;
    serviceDependencies = [ serverType ];
    settings = {
      auth = {
        botToken = "MTA5ODA4Njg3NDUxMTMzMTM2MA.GkheOj.aOtTw3OYO4_EEh8hoI-T3yjvgZX-1arH2oyrCs";
        clientID = "1098086874511331360";
      };
      database = {
        filename = "/var/lib/matrix/appservice-discord.db";
        #filename = "/var/lib/matrix-appservice-discord/discord.db";
      };
      bridge = {
        domain = matrix_hostname;
        # TODO: Enable TLS
        # TODO: Set port based on homeserver config.
        homeserverUrl = "http://${hostname}:6167";
      };
    };
    url = "http://localhost:${toString config.services.matrix-appservice-discord.port}";
  };

  services.matrix-appservice-irc = {
    enable = false;
    localpart = "appservice-irc";
    needBindingCap = false;
    passwordEncryptionKeyLength = 8192;
    port = 8009;
    registrationUrl = "http://localhost:8009";
    settings = {
      database = rec {
        engine = "postgres";  # nedb
        connectionString = dbConnectionString { type="postgres"; user = "matrix"; password = ""; host = "localhost"; database = "matrix-${hostname}-appservice-irc"; };
      };
      homeserver = {
        domain = hostname;
        url = "matrix.${hostname}";
      };
      ircService = {
        passwordEncryptionKeyPath = config.age.secrets."matrix-appservice-irc_password-encryption-key".path;
        servers = [];
      };

    };
  };

  # --- Facebook -----------------------
  services.mautrix-facebook = {
    enable = true;
  };

  # --- Telegram -----------------------
  services.mautrix-telegram = {
    enable = true;
    # file containing the appservice and telegram tokens
    environmentFile = "/etc/secrets/mautrix-telegram.env";

    # The appservice is pre-configured to use SQLite by default.
    # It's also possible to use PostgreSQL.
    settings = {
      homeserver = {
        address = "http://localhost:8008";
        domain = matrix_hostname;
      };
      appservice = {
        provisioning.enabled = false;
        id = "telegram";
        public = {
          enabled = true;
          prefix = "/public";
          external = "http://domain.tld:8080/public";
        };

        # The service uses SQLite by default, but it's also possible to use
        # PostgreSQL instead:
        #database = "postgresql:///mautrix-telegram?host=/run/postgresql";
      };
      bridge = {
        relaybot.authless_portals = false;
        permissions = {
          "@someadmin:domain.tld" = "admin";
        };

        # Animated stickers conversion requires additional packages in the
        # service's path.
        # If this isn't a fresh installation, clearing the bridge's uploaded
        # file cache might be necessary (make a database backup first!):
        # delete from telegram_file where \
        #   mime_type in ('application/gzip', 'application/octet-stream')
        animated_sticker = {
          target = "gif";
          args = {
            width = 256;
            height = 256;
            fps = 30;               # only for webm
            background = "020202";  # only for gif, transparency not supported
          };
        };
      };
    };
  };
  systemd.services.mautrix-telegram.path = with pkgs; [
    lottieconverter  # for animated stickers conversion, unfree package
    ffmpeg           # if converting animated stickers to webm (very slow!)
  ];


  # --- Discord ------------------------
  services.mx-puppet-discord = {
    enable = true;
    # https://github.com/matrix-discord/mx-puppet-discord/blob/master/sample.config.yaml
    settings = {
      bridge = {
        port = 8434;
        bindAddress = "localhost";
        domain = hostname;
        homeserverUrl = "matrix.${hostname}";  # "matrix-conduit.${hostname}";
        mediaUrl = hostname;
      };
      loginSharedSecretMap = {
        ${hostname} = config.age.secrets."matrix-${hostname}-puppet-discord";
      };
      #avatarUrl = "mxc://${hostname}/somestring123";
      database = {
        filename = "/var/lib/matrix/puppet-discord.db";
        #connString: "postgres://user:pass@localhost/dbname?sslmode=disable"
      };
      #enableGroupSync = true;
      presence.enabled = true;

      # Regex of Matrix IDs allowed to use the puppet bridge
      provisioning.whitelist = [
        "@admin:${hostname}"
        "@.*:${hostname}"
      ];

      # Regex of Matrix IDs allowed to use the bridge in relay mode (single Discord bot account relay's messages of multiple Matrix users.
      relay = {
        whitelist = [
          "@.*.${hostname}"
          #"@.*:server\\.com"  # Specific homeserver
          #".*"    # Anyone
        ];
        blacklist = [];
      };
      selfService.whitelist = ["@.*:${hostname}"];
    };
  };

}
