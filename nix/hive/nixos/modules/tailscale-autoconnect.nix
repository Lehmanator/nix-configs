{ config, lib, pkgs, ... }: 
let
  cfg = config.tailscale;
in
{
  # imports = [
  #   inputs.impermanence.nixosModules.impermanence
  #   inputs.sops-nix.nixosModules.sops
  # ];

  options = {
    tailscale = {
      enable = lib.mkEnableOption "tailscaleAutoconnect";
      authkeyFile = lib.mkOption {
        type = lib.types.str;
        description = "The authkey to use for authentication with Tailscale";
      };

      loginServer = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "The login server to use for authentication with Tailscale";
      };

      # TODO: tailscale.exit-node
      advertiseExitNode = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to advertise this node as an exit node";
      };
      exitNode = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "The exit node to use for this node";
      };
      exitNodeAllowLanAccess = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to allow LAN access to this node";
      };

      tailnet = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Your tailscale tailnet base URL";
      };

      # TODO: tailscale.funnel
      useFunnel = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to use tailscale funnel";
      };
      funnelPorts = lib.mkOption {
        type = lib.types.listOf lib.types.port;
        default = [443 8443 10000];
        description = "Ports to forward over tailscale funnel";
      };

      # TODO: tailscale.magicDNS
      useMagicDNS = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to use tailscale MagicDNS";
      };

      # TODO: tailscale.subnet-router.{certs,subnets,userspace}
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.authkeyFile != "";
        message = "authkeyFile must be set";
      }
      {
        assertion = cfg.exitNodeAllowLanAccess -> cfg.exitNode != "";
        message = "exitNodeAllowLanAccess must be false if exitNode is not set";
      }
      {
        assertion = cfg.advertiseExitNode -> cfg.exitNode == "";
        message = "advertiseExitNode must be false if exitNode is set";
      }
    ];

    environment = 
    #  let
    #   isGnome = config.services.xserver.desktopManager.gnome.enable;
    #   isKde = config.services.xserver.desktopManager.plasma5.enable;
    #   isOther = config.services.xserver.enable && (!isGnome) && (!isKde);

    #   # Impermanence & Persistence
    #   hasPersist = config.environment ? "persistence";
    #   persistDir = if hasPersist then
    #     builtins.head (builtins.attrNames config.environment.persistence)
    #     else "/var/lib/tailscale";

    # in 
    {
      systemPackages = [
        pkgs.tailscale
      # ] ++ lib.optionals isKde [
        pkgs.ktailctl
      #] ++ lib.optionals isGnome [
        pkgs.trayscale
        pkgs.gnomeExtensions.tailscale-qs
        pkgs.gnomeExtensions.tailscale-status
        #pkgs.gnomeExtensions.taildrop-send
      #] ++ lib.optionals isOther [
        # pkgs.trayscale
        pkgs.tailscale-systray
      ];
      
    # } // lib.optionalAttrs hasPersist {
    #   persistence.${persistDir}.directories = ["/var/lib/tailscale"];
    }; 

    networking = {
      firewall = {
        trustedInterfaces = [ "tailscale0" ];
        allowedUDPPorts = [ config.services.tailscale.port ] ++ lib.optionals cfg.useFunnel [cfg.funnelPorts];
      };
      nameservers = lib.mkIf cfg.useMagicDNS (lib.mkBefore ["100.100.100.100"]);
      search = lib.mkIf cfg.useMagicDNS [cfg.tailnet];
    };

    sops.secrets.tailscale-autoconnect-authkey = {
      restartUnits = ["tailscale-autoconnect.service"];
      sopsFile = ../../hosts/${config.networking.hostName/secrets/tailscale.yaml};
      path = cfg.authkeyFile;
    };

    services.tailscale = {
      enable = true;
      useRoutingFeatures = if cfg.advertiseExitNode then "server" else "client";
    };

    systemd.services.tailscale-autoconnect = {
      description = "Automatic connection to Tailscale";

      # make sure tailscale is running before trying to connect to tailscale
      after = ["network-pre.target" "tailscale.service"];
      wants = ["network-pre.target" "tailscale.service"];
      wantedBy = ["multi-user.target"];

      serviceConfig.Type = "oneshot";

      script = with pkgs; ''
        # wait for tailscaled to settle
        sleep 2

        # check if we are already authenticated to tailscale
        status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
        # if status is not null, then we are already authenticated
        echo "tailscale status: $status"
        if [ "$status" != "NeedsLogin" ]; then
            exit 0
        fi

        # otherwise authenticate with tailscale
        # timeout after 10 seconds to avoid hanging the boot process
        ${coreutils}/bin/timeout 10 ${tailscale}/bin/tailscale up \
          ${lib.optionalString (cfg.loginServer != "") "--login-server=${cfg.loginServer}"} \
          --authkey=$(cat "${cfg.authkeyFile}")

        # we have to proceed in two steps because some options are only available
        # after authentication
        ${coreutils}/bin/timeout 10 ${tailscale}/bin/tailscale up \
          ${lib.optionalString (cfg.loginServer != "") "--login-server=${cfg.loginServer}"} \
          ${lib.optionalString (cfg.advertiseExitNode) "--advertise-exit-node"} \
          ${lib.optionalString (cfg.exitNode != "") "--exit-node=${cfg.exitNode}"} \
          ${lib.optionalString (cfg.exitNodeAllowLanAccess) "--exit-node-allow-lan-access"}
      '';
    };
  };
}
