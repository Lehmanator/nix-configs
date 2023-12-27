{ inputs
, config
, lib
, pkgs
, ...
}:
# See: https://nixos.wiki/wiki/Samba
# Mounting:
#  $ mkdir -p /mnt/samba/${SAMBA_SHARE_NAME}
#  $ sudo mount.cifs -o sec=none //${SAMBA_HOST}/${SAMBA_SHARE_NAME} /mnt/samba/${SAMBA_SHARE_NAME}
{
  environment.systemPackages = [ pkgs.cifs-utils ]; # Install package required to mount Samba shares TODO: Necessary?

  services = {
    gvfs.enable = true; # FUSE filesystem mounting TODO: Conditional if using desktop?

    # Samba Web Services Dynamic Discovery
    samba-wsdd = {
      enable = true;
      discovery = true; # Enable discovery operation mode  # Default=false
      domain = "PI.local"; # Disables workgroup               # Default=null;
      extraOptions = [ "--no-host" ]; # Disable broadcasting  # Default=[]
      #"--ipv4only" "--no-http" "--shortlog" "--verbose"
      hoplimit = 2; # Max number of network hops       # Default=1
      #hostname = config.networking.hostName;                 # Default=null
      #interface = "eth0";                                    # Default=null
      #listen = "/run/wsdd/samba-wsdd.sock";                  # Default="/run/wsdd/wsdd.sock";
      #workgroup = "";                                        # Default=null
    };
  };

  networking.firewall = with config.services.samba-wsdd; {
    allowedTCPPorts = lib.mkIf (enable && discovery) [ 5357 ]; # TODO: Only for broadcast?...use only when
    allowedUDPPorts = lib.mkIf (enable && discovery) [ 3702 ]; # TODO:  `extraOptions` missing `--no-host`

    # Discovery of machines & shares may need this firewall rule
    # TODO: Use `networking.firewall.allowedUDPPorts = [137]` instead?
    #extraCommands = ''${pkgs.iptables} -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';
  };
}
