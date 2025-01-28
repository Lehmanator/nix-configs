{config, ...}: let
  # --- Countries / Territories ---
  #
  # --- Cities US ---
  # ashburn, va; atlanta, ga;   boston, ma;      chicago, il;
  #  dallas, tx;  denver, co;  houston, tx;   losangeles, ca; miami, fl
  # newyork, ny; phoenix, az;  raleigh, nc; saltlakecity, ut;
  # sanjose, ca; seattle, wa; secaucus, nj;
  default-peer = {
    allowedIPs = ["0.0.0.0/0" "::0/0"];
    persistentKeepalive = 10;
  };
  mv-ashburn-001 =
    default-peer
    // {
      endpoint = "198.54.135.34:51820"; #
      publicKey = "UKNLCimke54RqRdj6UFyIuBO6nv2VVpDT3vM9N25VyI=";
    };
  mv-ashburn-002 =
    default-peer
    // {
      endpoint = "198.54.135.66:51820"; #
      publicKey = "UUCBSYnGq+zEDqA6Wyse3JXv8fZuqKEgavRZTnCXlBg=";
    };
  mv-ashburn-003 =
    default-peer
    // {
      endpoint = "198.54.135.98:51820"; #
      publicKey = "0s0NdIzo+pq0OiHstZHqapYsdevGQGopQ5NM54g/9jo=";
    };
  mv-ashburn-004 =
    default-peer
    // {
      endpoint = "198.54.135.130:51820"; #
      publicKey = "TvqnL6VkJbz0KrjtHnUYWvA7zRt9ysI64LjTOx2vmm4=";
    };
  mv-ashburn-102 =
    default-peer
    // {
      endpoint = "185.156.46.143:51820"; #
      publicKey = "5hlEb3AjTzVIJyYWCYvJvbgA4p25Ltfp2cYnys90LQ0=";
    };
  mv-ashburn-103 =
    default-peer
    // {
      endpoint = "185.156.46.156:51820"; #
      publicKey = "oD9IFZsA5sync37K/sekVXaww76MwA3IvDRpR/irZWQ=";
    };
  mv-newyork-001 =
    default-peer
    // {
      endpoint = "198.54.135.130:51820"; #
      publicKey = "UKNLCimke54RqRdj6UFyIuBO6nv2VVpDT3vM9N25VyI=";
    };
  # old = default-peer // {
  #    allowedIPs = [ "0.0.0.0/0" "::0/0" ];
  #    endpoint = "198.54.135.130:51820"; #
  #    persistentKeepalive = 10; # 25
  #   publicKey = "LC9AMKbxjpk2wRO979J32X4OM07JiPhxjIDdvazDHQE=";
  #   #publicKey = "TvqnL6VkJbz0KrjtHnUYWvA7zRt9ysI64LjTOx2vmm4=";
  # };
  default-conf = {
    #allowedIPsAsRoutes = true;
    allowedIPsAsRoutes = false;
    mtu = 1420;
    generatePrivateKeyFile = false;
    privateKeyFile = "/etc/wireguard/sea1-admin.privkey";
    persistentKeepalive = 25;
    #ips = [ ];
  };
in {
  networking.wireguard.interfaces = {
    wg-mvusa =
      default-conf
      // {
        listenPort = 42271;
        privateKeyFile = "/etc/wireguard/sea1-admin.privkey"; # OR "/run/secrets";  #"/run/agenix";  #"/etc/keys/host/${host.hostname}"
        ips = [
          "192.168.124.1/32"
          # "10.66.199.133/32"
          "fc00:bbbb:bbbb:bb01::3:c784/128"
        ];
        peers = [
          mv-ashburn-001
          mv-ashburn-002
          mv-ashburn-003
          mv-ashburn-004
          mv-ashburn-102
          mv-ashburn-103
          #mv-newyork-001
        ];

        # preSetup = "";
        # postShutdown = "";
        # postSetup = "${pkgs.iptables} -I OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT && ip6tables -I OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT";    # PostUp
        # preShutdown = "${pkgs.iptables} -D OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT && ip6tables -D OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT";  # PreDown
      };
  };
}
