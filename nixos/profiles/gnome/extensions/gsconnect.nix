{ inputs, config, lib, pkgs, ... }:
let
  implementation = "valent";
  prefer-flatpak = false;

  unstable = inputs.nixpkgs-master.legacyPackages.${pkgs.system};

  walbottle = pkgs.callPackage (inputs.self + /nixos/packages/walbottle.nix) {};

  valent-app = unstable.valent.overrideAttrs (p: {
    version = "1.0.0.alpha.47-unstable-2025-01-09";
    src = pkgs.fetchFromGitHub {
      owner = "andyholmes";
      repo = "valent";
      rev = "49014fa095f69c5b8c9e42aaae4faff402f6dc73";
      hash = "sha256-88l5Na/TLDamDnqce3CxLopT0V5Lp276zalM2mxeBmc=";
      fetchSubmodules = true;
    };

    # TODO: Figure out how to re-enable pulseaudio plugin
    mesonFlags        = p.mesonFlags        ++ [(lib.mesonBool "plugin_pulseaudio" false)];
    nativeBuildInputs = p.nativeBuildInputs ++ [pkgs.libsysprof-capture walbottle];
    buildInputs       = p.buildInputs       ++ [pkgs.appstream pkgs.cmake];
    # ++ (with pkgs; [libcanberra gsound pulseaudioFull libpulseaudio]);
    # passthru.updateScript = { };
  });

  valent-ext = unstable.gnomeExtensions.valent.overrideAttrs (p: {
    version = "1.0.0.alpha.47-unstable-2024-11-14";
    src = pkgs.fetchFromGitHub {
      owner = "andyholmes";
      repo = "gnome-shell-extension-valent";
      rev = "99ff268a8fc64416c62512efb4710410ea1ee4b5";
      hash = "sha256-jmafFcoTBav9gV3MCPh1nJkCoIlCAwJ8GqOmRyFElyk=";
      fetchSubmodules = true;
    };
    # passthru.updateScript = { # };
  });
in
{

  programs.kdeconnect = {
    enable = true;  
    package = if implementation == "valent"     then valent-ext
         else if implementation == "gsconnect"  then pkgs.gnomeExtensions.gsconnect
         else if implementation == "kdeconnect" then pkgs.kdePackages.kdeconnect-kde
         else valent-ext
    ;
  };
  
  # Allow GSConnect thru firewall
  # TODO: Only allow thru wireguard tunnels
  # TODO: SFTP ports?
  networking.firewall = {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
    interfaces.tailscale0 = {
      allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
      allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
    };
  };

  # Enable Firefox integration
  programs.firefox.nativeMessagingHosts.packages = [ config.programs.kdeconnect.package valent-ext ];

  # Install implementation of GSConnect & shell-extension
  environment.systemPackages = [ config.programs.kdeconnect.package valent-app ];

  services.flatpak = lib.mkIf (prefer-flatpak && (implementation == "valent")) {
    remotes  = [{   name = "valent"; location = "https://valent.andyholmes.ca/repo"; }];
    packages = [{ origin = "valent";    appId = "ca.andyholmes.Valent";              }];
  };

  # TODO: DConf settings for GSConnect / Valent GNOME extensions
  # programs.dconf.profiles.user.databases.settings."ca/andyholmes/valent/device/${uuid}" = {
  #   plugin = {
  #     notification.forwardDeny = []
  #       ++ lib.optional (builtins.elem pkgs.flare   config.environment.systemPackages) "Flare"
  #       ++ lib.optional (builtins.elem pkgs.fractal config.environment.systemPackages) "Fractal"
  #     ;
  #   };
  # };

  # TODO: Home-Manager config options
  # home-manager.sharedModules = [
  #   ({ config, osConfig, pkgs, ... }@moduleArgs: 
  #   let
  #     hasPackage = import (inputs.self + /hm/lib/hasPackage.nix) moduleArgs;
  #     # hasApp = pname: n: 
  #     #   (builtins.elem pkgs.${pname} config.home.packages) || (
  #     #     (lib.getAttrFromPath ["environment" "systemPackages"] osConfig) &&
  #     #     (builtins.elem pkgs.${pname} osConfig.environment.systemPackages)
  #     # );
  #   in
  #   {
  #     dconf.settings."ca/andyholmes/valent" = {
  #       device."UUID".plugin.notification.forwardDeny = []
  #         ++ lib.optional (hasPackage "flare") "Flare"
  #         # ++ lib.optional (builtins.elem pkgs.flare   config.home.packages) "Flare"
  #         # ++ lib.optional (builtins.elem pkgs.fractal config.home.packages) "Fractal"
  #       ;
  #     };
  #   })
  # ];
}
