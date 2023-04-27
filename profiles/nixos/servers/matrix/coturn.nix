{ self, inputs, config, lib, pkgs,
  settings,
  ...
}:
  # https://coturn.github.io/
  # https://github.com/coturn/coturn
  # https://nixos.wiki/wiki/Matrix
  # https://search.nixos.org/options?channel=unstable&show=services.coturn.secure-stun&from=0&size=50&sort=alpha_asc&type=packages&query=coturn

with settings;
{
  imports = [
    inputs.agenix.nixosModules.age
    #../coturn.nix
  ];

  services = {

    coturn = {
      enable = true;
      extraConfig = ''
      '';
    };

    matrix-synapse = {
      # with config.services.coturn; { turn_uris = ["turn:${realm}:3478?transport=udp"]; };
      turn_shared_secret = config.age.secrets."matrix-synapse-turn-shared-secret".path;
      turn_uris = [
        "turn:turn.${server_name}:${config.services.coturn.listening-port}?transport=udp"
        "turn:turn.${server_name}:${config.services.coturn.listening-port}?transport=tcp"
        "turns:turn.${server_name}:${config.services.coturn.ltls-istening-port}?transport=udp"
        "turns:turn.${server_name}:${config.services.coturn.tls-listening-port}?transport=tcp"
      ];
    };

    dendrite.settings.global.turn = {
      turn_user_lifetime = "5m";
      turn_uris = [
        "turn:turn.${server_name}?transport=udp"
        "turn:turn.${server_name}?transport=tcp"
      ];
      #turn_secret = "";  # static-auth-secret of turnserver
      #turn_username = "";
      #turn_password = "";
    };

    matrix-conduit.settings.global = {
      turn_uris = [
        "turn:turn.${server_name}?transport=udp"
        "turn:turn.${server_name}?transport=tcp"
      ];
      #turn_secret = "";  # static-auth-secret of turnserver
      #turn_username = "";
      #turn_password = "";
    };
  };

  # TODO: Handle Wireguard
  networking.firewall = let range = with config.services.coturn; [{
    from = min-port; to = max-port;
  }]; in  # interfaces.enp2s0.
  {
    allowedUDPPortRanges = range;
    allowedUDPPorts = [ 3478 5349 ];
    allowedTCPPortRanges = [];
    allowedTCPPorts = [ 3478 5349 ];
  };
}
