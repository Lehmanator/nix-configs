{
  self, input, config, lib, pkgs,
  host, user, repo, network,
  ...
}:
let
  hostname = host.domain or "redstone.pw";
in
{
  imports = [
  ];

  services.matrix-conduit = {
    enable = true;
    extraEnvironment = {
      RUST_BACKTRACE = "yes";
    };
    settings = {
      global = {
        address = "::1";
        allow_encryption = true;
        allow_federation = true;
        allow_registration = true;
        database_backend = "sqlite";
        database_path = "/var/lib/matrix-conduit/";
        max_request_size = 20000000;
        port = 6167;
        server_name = hostname;
        trusted_servers = [
          "matrix.org"
        ];
      };
    };
  };
}
