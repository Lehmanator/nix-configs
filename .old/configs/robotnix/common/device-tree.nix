
{ self, inputs, config, lib, pkgs,
  host, network, repo,
  device ? "flame",
  oem    ? "google",
  ...
}:
let
  # --- Chromium Patchsets ---------------------------------
  device-trees = let
    inherit device oem;
  in {
    disabled = [
    ];

    enabled = [
      { name = "CalyxOS";    id="calyx";
        repo = "https://github.com/CalyxOS/device_${oem}_${device}"; }
      { name = "GrapheneOS"; id="graphene";
        repo = ""; }
      { name = "DivestOS";   id="divest";
        repo = ""; }
      { name = "LineageOS";  id="lineage";
        repo = ""; }
      { name = "iodeOS";     id = "iode";
        repo = "https://gitlab.com/iode/os/public/devices/google/device_${oem}_${device}";
      }
    ];
  };
in
{ 
  imports = [];
}
