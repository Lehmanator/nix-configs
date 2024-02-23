{pkgs, ...}: {
  # --- Sandboxing ---------------------
  nix.settings = {
    sandbox = true; # Sandbox Nix builds
    fallback = true; # Fallback to local build if substitute fails
    # Expose extra system paths to Nix build sandbox
    extra-sandbox-paths = [];
  };
}
