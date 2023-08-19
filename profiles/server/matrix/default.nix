{ self, inputs, config, lib, pkgs,
  host, repo, user, network, machine,
  #settings,
  ...
}: let
  settings = rec {
    preferred_homeserver = "conduit";

    server_name = "redstone.pw";                # Hostname that appears in user & room IDs
    matrix_hostname = "matrix.${server_name}";  # Hostname that Conduit actually runs on
    admin_email = "admin@${server_name}";       # An admin email for TLS certificate notifications

    # Build a dervation that stores the content of `${server_name}/.well-known/matrix/server`
    well_known_server = pkgs.writeText "well-known-matrix-server" ''
      {
        "m.server": "${matrix_hostname}"
      }
    '';

    # Build a dervation that stores the content of `${server_name}/.well-known/matrix/client`
    well_known_client = pkgs.writeText "well-known-matrix-client" ''
      {
        "m.homeserver": {
          "base_url": "https://${matrix_hostname}"
        }
      }
    '';
  };
in
{
  imports = with settings; [
    ./homeserver-${preferred_homeserver}.nix { inherit settings; }
    #./bots.nix         { inherit settings; }
    #./bridges.nix      { inherit settings; }
    #./identity.nix     { inherit settings; }
    #./integrations.nix { inherit settings; }
    #./media.nix        { inherit settings; }
    #./turn.nix         { inherit settings; }
  ];

  services.nginx = with settings; {
    enable = true;
    recommendedProxySettings = true;

    virtualHosts."${matrix_hostname}" = {
      forceSSL = true;
      enableACME = true;

      listen = [
        { addr = "0.0.0.0"; port = 443;  ssl = true; }
        { addr = "0.0.0.0"; port = 8448; ssl = true; }
      ];
      locations."/_matrix/" = {
        proxyPass = "http://backend_${preferred_homeserver}$request_uri";
        #proxyPass = "http://backend_homeserver$request_uri";
        proxyWebsockets = true;
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_buffering off;
        '';
      };
      extraConfig = ''
        merge_slashes off;
      '';
    };
    virtualHosts."${server_name}" = {
      forceSSL = true;
      enableACME = true;

      locations."=/.well-known/matrix/server" = {
        alias = "${well_known_server}";   # Use the contents of the derivation built previously
        extraConfig = ''
          # Set the header since by default NGINX thinks it's just bytes
          default_type application/json;
        '';
      };
      locations."=/.well-known/matrix/client" = {
        alias = "${well_known_client}";   # Use the contents of the derivation built previously
        extraConfig = ''
          # Set the header since by default NGINX thinks it's just bytes
          default_type application/json;
          # https://matrix.org/docs/spec/client_server/r0.4.0#web-browser-clients
          add_header Access-Control-Allow-Origin "*";
        '';
      };
    };
    upstreams = rec {
      backend_homeserver = if preferred_homeserver == "conduit" then backend_conduit else if preferred_homeserver == "dendrite" then backend_dendrite else backend_synapse;
      backend_conduit.servers."localhost:${toString config.services.matrix-conduit.settings.global.port}" = {};
      backend_dendrite.servers."localhost:${toString config.services.dendrite.settings.httpPort}" = {};
      backend_synapse.servers."localhost:8008" = {};
      #backend_synapse.servers."localhost:${toString config.services.matrix-synapse.settings.global.port}" = {};
    };
  };

  # Open firewall ports for HTTP, HTTPS, and Matrix federation
  networking.firewall.allowedTCPPorts = [ 80 443 8448 ];
  networking.firewall.allowedUDPPorts = [ 80 443 8448 ];
}
