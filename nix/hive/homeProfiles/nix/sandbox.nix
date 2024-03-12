{ pkgs, lib, ... }: {
  # --- Sandboxing ---------------------
  nix.settings = {
    # Sandbox Nix builds
    sandbox = true;

    # Fallback to local build if substitute fails
    fallback = lib.mkDefault true;

    # Expose extra system paths to Nix build sandbox
    extra-sandbox-paths = lib.mkDefault [ ];
  };
}
