{ inputs, pkgs, ... }: {
  nixpkgs.overlays = [
    inputs.fenix.overlays.default
    inputs.lanzaboote.overlays.default
    inputs.nix-alien.overlays.default
    inputs.nixpkgs-gnome-apps.overlays.default
    inputs.nur.overlay
    inputs.ssbm-nix.overlay

    # --- Overlaying Alternative Package Sets ---
    #(final: prev: {       stable = flake-utils.lib.eachDefaultSystem (system: nixos-stable.legacyPackages.${system});    })
    #(final: prev: {     unstable = flake-utils.lib.eachDefaultSystem (system: nixos-unstable.legacyPackages.${system});  })
    #(final: prev: {       master = flake-utils.lib.eachDefaultSystem (system: nixos-master.legacyPackages.${system});    })
    #(final: prev: {      staging = flake-utils.lib.eachDefaultSystem (system: nixos-staging.legacyPackages.${system});   })
    #(final: prev: { gnome-latest = flake-utils.lib.eachDefaultSystem (system: nixpkgs-gnome.legacyPackages.${system});   })
    #(final: prev: { wayland-pkgs = flake-utils.lib.eachDefaultSystem (system: nixpkgs-wayland.legacyPackages.${system}); })
    #(final: prev: {  android-sdk = flake-utils.lib.eachDefaultSystem (system: nixpkgs-android.legacyPackages.${system}); })
    #(final: prev: {          nur = flake-utils.lib.eachDefaultSystem (system:          nur.legacyPackages.${system});    })
  ];

  #environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf config.nixpkgs.config.allowUnfree "1" ;
}
