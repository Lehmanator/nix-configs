{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  # --- Nixpkgs --------------------------------------------
  nixpkgs = {
    # --- Overlays -----------------------
    # Nix overlays are used to override packages
    overlays = with inputs; [
      nur.overlay
      #(final: prev: {
      #  gnome-decoder = prev.gnome-decoder.overrideAttrs (attrs: {
      #    preBuild = ''
      #      export BINDGEN_EXTRA_CLANG_ARGS="$BINDGEN_EXTRA_CLANG_ARGS -DPW_ENABLE_DEPRECATED"
      #    '';
      #    meta.broken = false;
      #  });
      #})

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

    # --- Package Config -----------------
    config = {
      allowBroken = false;
      allowUnfree = true;

      packageOverrides = pkgs: {
        electron_24 = pkgs.electron_25; # Electron v24 is end-of-life, forcing upgrade
      };
    };

  };

  #environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf config.nixpkgs.config.allowUnfree "1" ;

}
