{ self, inputs, config, lib, pkgs,
  host, network, repo,
  device ? "flame",
  oem    ? "google",
  ...
}: {
  imports = [];

  vendors = [
    "https://github.com/orgs/AOSPA"
    "https://github.com/Evolution-X"
    "https://github.com/arrowos"
    "https://github.com/omnirom"
    "https://github.com/dotos"
    "https://github.com/BlissRoms-Devices"
    "https://github.com/BlissRoms"
    "https://github.com/crdroidandroid"
    "https://github.com/PixysOS"
    "https://github.com/DerpFest-AOSP"
    "https://github.com/DerpFest-Devices"
    "https://github.com/Spark-Rom"
    "https://github.com/PixelPlusUI"
    "https://github.com/Project-Elixir"
    "https://github.com/Nameless-AOSP"
  ];
}
