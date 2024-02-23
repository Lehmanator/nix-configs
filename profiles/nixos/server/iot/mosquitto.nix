{ self, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    ./common.nix
  ];

  services.mosquitto = {
    enable = true;
    bridges = {
      #<name> = {
      #  addresses = [
      #    { address = "192.168.1.160"; port = 1883; }
      #  ];
      #  settings = {
      #  };
      #  topics = [
      #    "# both 2 local/topic/ remote/topic/"
      #  ];
      #};
    };
    dataDir = "/var/lib/mosquitto";
    includeDirs = [];
    listeners = {
      #<name> = {
      #  acl = [
      #    "pattern read #"
      #    "topic readwrite anon/report/#"
      #  ];
      #  address = "0.0.0.0/::";
      #  # https://mosquitto.org/man/mosquitto-conf-5.html
      #  authPlugins = [
      #    { denySpecialChars = true; options = {}; plugin = <path>.so; }
      #  ];
      #  omitPasswordAuth = false;
      #  port = 1883;
      #  settings = {};
      #  users = {
      #    sam = {
      #      acl = [
      #        "readwrite sam/#"
      #      ];
      #      password = "123456";
      #      passwordFile = <path>;
      #    };
      #  };
      #};
    };
    logDest = [ "stderr" ]; # stdout | stderr | syslog | topic | dlt
    logType = [];  # debug | error | warning | notice | information | subscribe | unsubscribe | websockets | none | all
    package = pkgs.mosquitto;
    persistence = true;
    settings = {
    };
  };

  services.home-assistant.extraComponents = [ "mqtt" "mqtt_eventstream" "mqtt_json" "mqtt_room" "mqtt_statestream" ];
}
