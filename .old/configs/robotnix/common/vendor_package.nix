
{ self, inputs, config, lib, pkgs,
  host, network, repo,
  ...
}:
let
  # --- Chromium Patchsets ---------------------------------
  vendorPackages = {
    disabled = [
    ];

    enabled = [
      { name = "CalyxOS"; id="calyx"; repo = "https://github.com/CalyxOS/chromium-patches"; }
      { name = "GrapheneOS"; id="graphene"; repo = ""; }
    ];
  };
in
{ 
  imports = [];
}
