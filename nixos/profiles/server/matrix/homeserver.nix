{ self, inputs, config, lib, pkgs,
  host, repo, user, network, machine,
  settings,
  ...
}: let
  matrix-settings = rec {
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
  imports = [
    ./homeserver-conduit.nix {
      inherit (matrix-settings) server_name matrix_hostname well_known_server well_known_client;
    }
    #./nginx.nix {
    #  inherit (matrix-settings) server_name matrix_hostname well_known_server well_known_client;
    #}
  ];

}
