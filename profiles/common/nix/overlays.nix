{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs = {
    overlays = with inputs; [
      fenix.overlays.default
      lanzaboote.overlays.default
      nix-alien.overlays.default
      nixpkgs-gnome-apps.overlays.default
      nur.overlay
      ssbm-nix.overlay

      #nvfetcher.overlays.default  # nvfetcher included in nixpkgs now

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
  };

  #environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf config.nixpkgs.config.allowUnfree "1" ;
}
