{
  name = "eri1";

  # Description of the physical location of the network
  location = {
    city = "Erie"; state = "Pennsylvania"; country = "US";
    latitude = ""; longitude = ""; elevation = "400 feet";
  };

  # Description of IP addresses of the network
  ip = {
    external.addr4 = "66.202.211.70"; external.mask4 = 32;
    external.addr6 = "";              external.mask6 = 128;
    internal.addr4 = "192.168.1.1";   internal.mask4 = 16;
  };

  # Description of all the network interfaces on the network
  interfaces = {
    eth0   = { name = "eth0";  type = "ethernet"; radio = null;     virtual = false; };
    wifi24 = { name = "wifi0"; type = "wifi";     radio = "2.4Ghz"; virtual = false; };
    wifi5  = { name = "wifi1"; type = "wifi";     radio = "5.0Ghz"; virtual = false; };
  };

  # Description of all the host computers on the network
  hosts = {
  };

  # Description of all services on the network
  services = {
    avahi = {
    };
    samba = {
    };
    dns = {
    };
    wireguard = {
    };
    nextcloud = {
    };
    home-assistant = {
    };
    esphome = {
    };
    hashicorp-vault = {
    };
  };

  # Description of all environment classes on the network
  environments = {
    personal = {
      name = "Personal";
      domain = "samlehman.me";
      channels = [
        { name = "Production";  type = "production";                      }
        { name = "Development"; type = "development"; subdomain = "dev";  }
      ];
    };
    developer = {
      name = "dev";
      domain = "samlehman.dev";
      channels = [
        { name = "Production";  type = "production";                      }
        { name = "Pre-release"; type = "staging";     subdomain = "next"; }
        { name = "Testing";     type = "testing";     subdomain = "test"; }
        { name = "Development"; type = "development"; subdomain = "dev";  }
      ];
    };
    pseudoanonymous = {
      name = "Redstone";
      domain = "redstone.pw";
      channels = [
        { name = "Production";  type = "production";                      }
        { name = "Development"; type = "development"; subdomain = "dev";  }
      ];
    };
    anonymous = {
      name = "Anonymous";
      domain = "";
      channels = [
        { name = "Production";  type = "production";                      }
        { name = "Development"; type = "development"; subdomain = "dev";  }
      ];
    };
    tor = {
      name = "Tor";
      domain = "<addr>.onion";
      channels = [
        { name = "Production";  type = "production";                      }
        { name = "Development"; type = "development"; subdomain = "dev";  }
      ];
    };
  };
}
