{ inputs, config, lib, pkgs, ... }:
{
  imports = ["${inputs.self}/nixos/profiles/wine.nix"];

  # --- Audio --------------------------------------------------------
  # Create ALSA loopback device, instead of using PCM plugin.
  #   Has broader application support (things like Steam will work),
  #    but may need fine-tuning for concrete hardware.
  services.jack.loopback.enable = lib.mkDefault false;

  # --- Hardware -----------------------------------------------------
  # Enable udev rules for Steam hardware (i.e. Steam Controller, other supported controllers, & HTC Vive)
  hardware.steam-hardware.enable = lib.mkDefault true;

  # --- Steam --------------------------------------------------------
  programs.steam = {
    enable = true;
    extest.enable = lib.mkDefault true;  # TODO: Condition on X11/Wayland DE/WM

    # Defaults to system fonts, but could be overridden to use other fonts.
    #   — useful for users who would like to customize CJK fonts used in Steam.
    # According to the [upstream issue](https://github.com/ValveSoftware/steam-for-linux/issues/10422#issuecomment-1944396010):
    #   Steam only follows the per-user fontconfig configuration.
    # fontPackages = builtins.filter lib.types.package.check config.fonts.packages;
    extraCompatPackages = [
      pkgs.proton-ge-bin
    ];

    # Additional packages to add to the Steam environment.
    # TODO: Add Adwaita theme for Steam app on GNOME
    extraPackages = [
      pkgs.gamescope
    ];

    # package = pkgs.steam.override {
    #   extraLibraries = p: with p; [ atk ];
    #   extraEnv = {
    #     MANGOHUD = true;
    #     RADV_TEX_ANISO = 16;
    #     OBS_VKCAPTURE = true;
    #   };
    # };

    protontricks = {
      enable = lib.mkDefault true;
      package = lib.mkDefault pkgs.protontricks;
    };

    # --- Firewall -----------------------------------------
    # Open ports in the firewall for Source Dedicated Server.
    dedicatedServer.openFirewall = lib.mkDefault false;

    # Open ports in the firewall for Steam Local Network Game Transfers.
    localNetworkGameTransfers.openFirewall = lib.mkDefault false;
    remotePlay.openFirewall = lib.mkDefault false;

    # --- GameScoope ---------------------------------------
    # Run a GameScope driven Steam session from your display-manager
    gamescopeSession = {
      enable = config.programs.gamescope.enable;
      args = [];
      env = {};
    };
  };
  programs.gamescope.enable = lib.mkDefault false;

  # --- ArchisSteamFarm Service ---------------------------------------
  #  To configure SteamGuard token, you must use the web-ui (enabled by default on 127.0.0.1:1242)
  #  Cant configure ASF at all outside Nix, bc config files replaced w/ ones set by Nix upon restart.
  # TODO: Other settings
  services.archisteamfarm = rec {
    enable = lib.mkDefault false;
    web-ui.enable = enable;
  };

  # --- PufferPanel Service ------------------------------------------
  # Whether to enable PufferPanel game management server.
  # NOTE: PufferPanel templates & bins expect FHS environment.
  #  It's possible to set package option to PufferPanel wrapped w/ FHS environment.
  #   Example: (use Download Game from Steam and Download Java template operations)
  services.pufferpanel = {
    enable = lib.mkDefault false;
    extraPackages = [ pkgs.bash pkgs.curl pkgs.gawk pkgs.gnutar pkgs.gzip ];
    package = pkgs.buildFHSEnv {
      name = "pufferpanel-fhs";
      runScript = lib.getExe pkgs.pufferpanel;
      targetPkgs = pkgs': with pkgs'; [ icu openssl zlib ];
    };
  };
}
