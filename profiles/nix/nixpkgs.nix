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
    overlays = [
      inputs.nur.overlay
      #(final: prev: {
      #  gnome-decoder = prev.gnome-decoder.overrideAttrs (attrs: {
      #    preBuild = ''
      #      export BINDGEN_EXTRA_CLANG_ARGS="$BINDGEN_EXTRA_CLANG_ARGS -DPW_ENABLE_DEPRECATED"
      #    '';
      #    meta.broken = false;
      #  });
      #})
    ];

    # --- Package Config -----------------
    config = {
      allowBroken = false;
      allowUnfree = true;
    };

  };

  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf config.nixpkgs.config.allowUnfree "1" ;

}
