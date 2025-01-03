{ inputs, config, lib, pkgs, ... }:
let
  implementation = "valent";
  prefer-flatpak = false;

  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};

  walbottle = pkgs.callPackage (inputs.self + /nixos/packages/walbottle.nix) {};

  valent-app = unstable.valent.overrideAttrs (p: {
    version = "1.0.0.alpha.47-unstable-2024-11-20";
    src = pkgs.fetchFromGitHub {
      owner = "andyholmes";
      repo = "valent";
      rev = "0ea090301e6095e4d2141e557b32a68e03f3452c";
      hash = "sha256-quSa3rXtRNvig31dfurbDllBDG4h09wRk9dhWEBLc+s=";
      fetchSubmodules = true;
    };

    # TODO: Figure out how to re-enable pulseaudio plugin
    mesonFlags = p.mesonFlags ++ [(lib.mesonBool "plugin_pulseaudio" false)];
    nativeBuildInputs = p.nativeBuildInputs ++ [pkgs.libsysprof-capture walbottle];
    buildInputs = p.buildInputs ++ [pkgs.appstream pkgs.cmake]; #[pkgs.libcanberra pkgs.gsound pkgs.pulseaudioFull pkgs.libpulseaudio];
    # passthru.updateScript = { };
  });

  valent-ext = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.gnomeExtensions.valent.overrideAttrs (p: {
    version = "1.0.0.alpha.47-unstable-2024-11-20";
    src = pkgs.fetchFromGitHub {
      owner = "andyholmes";
      repo = "gnome-shell-extension-valent";
      rev = "99ff268a8fc64416c62512efb4710410ea1ee4b5";
      hash = "sha256-jmafFcoTBav9gV3MCPh1nJkCoIlCAwJ8GqOmRyFElyk=";
      fetchSubmodules = true;
    };
    # passthru.updateScript = { # };
  });

  extension-package = if implementation=="valent"
    then valent-ext else pkgs.gnomeExtensions.gsconnect;
in
{

  programs.kdeconnect = {
    enable = true;  
    package = valent-app;
  };
  
  # Allow GSConnect thru firewall
  # TODO: Only allow thru wireguard tunnels
  networking.firewall = {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };

  # Enable Firefox integration
  programs.firefox.nativeMessagingHosts.packages = [
    config.programs.kdeconnect.package
    pkgs.gnomeExtensions.gsconnect
    valent-ext
  ];

  # Install implementation of GSConnect & shell-extension
  environment.systemPackages = [
    config.programs.kdeconnect.package
    pkgs.gnomeExtensions.gsconnect
    valent-ext
  ];

  services.flatpak = lib.mkIf prefer-flatpak {
    remotes  = [{ name="valent"; location = "https://valent.andyholmes.ca/repo"; }];
    packages = []
      ++ lib.optional (implementation=="valent")     [{ origin="valent";  appId="ca.andyholmes.Valent"; }]
      ++ lib.optional (implementation=="kdeconnect") [{ origin="flathub"; appId=""; }]
    ;
  };

  # TODO: DConf settings for GSConnect / Valent GNOME extensions
}
