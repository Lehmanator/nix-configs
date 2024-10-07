{ inputs, config, lib, pkgs, user, ... }:
{
  # TODO: Configure SFTP
  # TODO: Configure SSH agent
  # TODO: Configure SSH certificates
  # TODO: Configure hardware keys
  # TODO: Configure Tor
  # TODO: Configure I2P
  # TODO: Harden configs
  # TODO: CanonicalDomains & CanonicalizeHostname
  # See: `man ssh_config(5)` for options.
  programs.ssh = {
    enable = true;

    # --- Connection -----------------------------
    compression = false;       # Compress data sent over connection
    serverAliveCountMax = 3;   # Max dropped keep-alive packats before terminating connection.
    serverAliveInterval = 0;   # Interval to resend keep-alive packets.

    # --- SSH Agent ------------------------------
    addKeysToAgent = "yes";
    forwardAgent = true;

    # --- Control Socket -------------------------
    controlMaster = "no";                       # Share multiple sessions over one connection. no (def), yes, ask, auto, autoask
    controlPath = "~/.ssh/master-%r@%n:%p";     # Control socket path for connection sharing. Default: "~/.ssh/master-%r@%n:%p"
    controlPersist = "no";                      # Time to keep control socket open in background. Default: "no"; Ex: "10m";

    # --- Known Hosts ----------------------------
    hashKnownHosts = true;                      # Whether to hash entries in known_hosts or store in plaintext
    userKnownHostsFile = "~/.ssh/known_hosts";  # Path to file w/ list of known hosts & their fingerprints

    # --- Extra Config ---------------------------
    includes = ["~/.ssh/host-*" "~/.ssh/rule-*"]; # SSH config file globs to include w/ Include directive.
    extraOptionOverrides = {                    # Options here take precedence over host-specific rules & match blocks.
      Protocol = "2";                           # Protocol version
      VisualHostKey = "yes";                    # Host key ASCII art
      # LocalCommand = ''"echo \"Login: `whoami`  on  `date`\""'';  # Command to run upon login
    }; 
    extraConfig = ''
      User ${user}
      AddressFamily any
      IdentityFile ~/.ssh/id_ed25519
      IdentityFile ~/.ssh/id_rsa
      CanonicalDomains tail6a8f8.ts.net lan local
    '';                                         # Options here are appended to the block: `Host *`
    
    # --- Match Rules ----------------------------
    # Custom rules for hosts. If rule order matters, express deps w/ DAG libs like example.
    matchBlocks = {                             # Type: DAG of submodule. Default: { }
      "github.com" = {                          # Configure SSH auth for git protocol.
        hostname = "github.com";                # ssh://git@github.com
        user = "git";                           # git@github.com:<username>/<repo>.git
        addressFamily = "inet";                 # GitHub only supports IPv4 (as of 9/2024)
        identitiesOnly = true;                  # GitHub disallows password auth
        identityFile = ["~/.ssh/id_ed25519"];   # "~/.ssh/id_rsa"];
        extraOptions = {
          VisualHostKey = "no";
        };
      };

      fajita = {                   # PostmarketOS USB network
        hostname = "172.16.42.1";  # USB network interface to PostmarketOS device
        user = "user";             # Default PostmarketOS username is "user"
        serverAliveCountMax = 3;   # Max dropped keep-alive packats before terminating connection.
        serverAliveInterval = 0;   # Interval to resend keep-alive packets.
        extraOptions = {
          StrictHostKeyChecking = "no";      # Disable warning host key changed if new device connected.
          UserKnownHostsFile = "/dev/null";  # Never save known_hosts entries.
          ConnectTimeout = "5";
          HostKeyAlias = "fajita";
        };
      };
      router = {
        inherit user;
        hostname = "66.211.202.71";
        identityFile = ["~/.ssh/id_ed25519" "~/.ssh/id_rsa"]; # Files to read user identity from. Tried in given order.
        addressFamily = "inet";                               # Local network only supoorts IPv4 (as of 9/2024)
        port = 22222;
      };


      # "*" = {
      #   inherit user;
      #   host = "*";                                           # Wildcard hostname: `Host *`
      #   addressFamily = "any";                                # Opts: any | inet | inet6
      #   identityFile = ["~/.ssh/id_ed25519" "~/.ssh/id_rsa"]; # Files to read user identity from. Tried in given order.
      #   extraOptions = {                                      # Options not in matchBlock submodule
      #     CanonicalDomains = "\"tail6a8f8.ts.net lan local\"";
      #       # ++ (lib.optional (config ? networking ? "domain" && config.networking.domain != null && config.networking.domain != "") config.networking.domain)
      #   };
      # };

      # "example.com" = {            # See: `man ssh_config(5)`
      #   checkHostIP = true;        # Check the host IP address in the known_hosts file.
      #   extraOptions = {};
      #   host = "*.example.com";    # Host pattern used. Ignored if ssh.matchBlocks.*.match defined

      #   # --- Networking -------------------------
      #   addressFamily = "any";     # null | "any" | "inet" | "inet6"
      #   hostname = "example";      # Specifies the real host name to log into.
      #   port = 2223;               # Port number to connect on remote host

      #   compression = false;       # Compress data sent over connection
      #   serverAliveCountMax = 3;   # Max dropped keep-alive packats before terminating connection.
      #   serverAliveInterval = 0;   # Interval to resend keep-alive packets.

      #   # --- Identities ------------------------
      #   inherit user;
      #   certificateFile = [];      # User certificate files to read
      #   identitiesOnly = true;     # SSH only use auth identity explicitly in CLI args or files: ~/.ssh/config
      #   identityFile = ["~/.ssh/id_ed25519" "~/.ssh/id_rsa"]; # Read identity files at paths. Tried in given order.

      #   # Match block conditions used by this block.
      #   # This option takes precedence over ssh.matchBlocks.*.host if defined.
      #   #  canonical, final, exec, localnetwork, host, originalhost, tagged, user, & localuser. 
      #   match = ''
      #     host <hostname> canonical
      #     host <hostname> exec "ping -c1 -q 192.168.17.1"
      #   '';

      #   # --- Forwarding -------------------------
      #   forwardAgent = false;      # Forward auth agent connection (if any) to remote machine
      #   forwardX11 = false;        # X11 connections auto redirected over secure channel & DISPLAY set.
      #   forwardX11Trusted = false; # Remote X11 clients will have full access to the original X11 display.

      #   proxyCommand = null;       # Command to use to connect to the server.
      #   proxyJump = "<hostname>";  # Proxy host to use to connect to the server.

      #   dynamicForwards = [{       # Forward TCP port local->remote via secure channel. Port determined by app protocol
      #     port = 8080;             # Port number to bind on bind address.
      #     address = "localhost";   # Address where to bind the port. Default: "localhost"
      #   }];

      #   localForwards = [{  # Forward TCP ports local->remote over secure channel. i.e. local can access ports on remote
      #     bind = { port=8033; address="localhost";   };  # Forward traffic from port/addr to remote (addr => iface)
      #     host = { port=8033; address="example.com"; };  # Forward traffic to remote port/addr      (addr => remote)
      #   }];

      #   # Forward TCP ports remote->local over secure channel. i.e. allow remote to access ports on local machine. 
      #   remoteForwards = [{ #  dest=null => remote-forwarding as SOCKS proxy => PermitRemoteOpen restricts connection dest.
      #     bind = { port=8080; address="localhost"; };    # Port/Addr to bind to
      #     host = { port=8080; address="10.0.0.13"; };    # Port/Addr to forward the traffic to.
      #   }];

      #   # --- Environment -------------------------
      #   # sendEnv = {"<name>" = "<value>"; };
      #   # setEnv  = {"<name>" = "<value>"; };
      # };
    };
  };
}
