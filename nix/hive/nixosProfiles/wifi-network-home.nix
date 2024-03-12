{ inputs, config, lib, pkgs, ... }: {
  sops.secrets."wifi-home.env" = {
    mode = "0440";
    owner = "networkmanager";
    group = "networkmanager";
    sopsFile = "${inputs.self}/secrets/network/home/networkmanager-env.yaml";
    format = "yaml";
  };

  # Writes config to /etc/NetworkManager/system-connections/{name}.nmconnection
  # https://developer.gnome.org/NetworkManager/stable/NetworkManager.conf.html
  networking.networkmanager.ensureProfiles = {
    environmentFiles = [ config.sops.secrets."wifi-home.env".path ];
    profiles = {
      home-wifi = {
        connection = {
          type = "wifi";
          id = "home-wifi";
          interface-name = "wlan0";
          #permissions = "";
        };
        wifi = {
          mac-address-blacklist = "";
          mac-address = "$WIFI_HOME_INTERFACE_MACADDRESS";
          #mac-address="$WIFI_HOME_ROUTER_MACADDRESS";
          mode = "infrastructure";
          ssid = "$WIFI_HOME_SSID";
        };
        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$WIFI_HOME_PASSWORD";
          #auth-alg = "oepn";
        };
        ipv4 = {
          dns = "192.168.1.1;100.100.100.100;1.1.1.1;9.9.9.9";
          dns-search = "";
          method = "manual";
        };
        ipv6 = {
          addr-gen-mode = "default"; # "stable-privacy";
          method = "disabled"; # "auto";
        };
        #proxy = {};
      };
    };
  };

  systemd.network = {
    netdevs.wlan0 = {
      netdevConfig = {
        Kind = "wlan";
        Name = "wlan0";
      };
      wlanConfig = {
        PhysicalDevice = 0;
        Type = "station";
      };
    };
    networks.home-wifi = {
      name = "home-wifi";
      enable = true;

      #DHCP = "";
      address = [ ];
      addresses = {
        NAME = { addressConfig = { Address = "192.168.0.1/24"; }; };
      };
      bfifoConfig = {
        LimitBytes = "20K";
        Parent = "ingress";
      };
      bond = [ ];
      bridgeConfig = {
        Cost = 20;
        MulticastFlood = false;
      };
      bridgeFDBs = [{
        bridgeFDBConfig = {
          Destination = "192.168.100.4";
          MACAddress = "90:e2:ba:43:fc:71";
          VNI = 3600;
        };
      }];
      bridgeMDBs = [{
        bridgeMDBConfig = {
          MulticastGroupAddress = "ff02::1:2:3:4";
          VLANId = 10;
        };
      }];
      bridgeVLANs = [{ bridgeVLANConfig = { VLAN = 20; }; }];
      cakeConfig = {
        Bandwidth = "40M";
        CompensationMode = "ptm";
        OverheadBytes = 8;
      };
      canConfig = { };
      controlledDelayConfig = {
        Parent = "ingress";
        TargetSec = "20msec";
      };
    };
  };
}
