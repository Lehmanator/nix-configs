{
  self,
  system,
  inputs,
  host, network, repo,
  userPrimary,
  config, lib, pkgs,
  ...
}:
{
  # --- Packages -----------------------
  # Use Nix package manager package with builtin flakes support
  nix.package = pkgs.nixFlakes;

  # https://nixos.wiki/wiki/Flakes
  # Note: channels & nixPath are legacy, but still often used by tooling
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  #nix.nixPath = let path = toString ./.; in [ "repl=${path}/repl.nix" "nixpkgs=${inputs.nixpkgs}" ];

  nix.settings.accept-flake-config = true;

  environment.shellAliases.ndoc = "manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
  environment.systemPackages = [
    pkgs.deadnix              # Find dead code in Nix configs
    pkgs.manix                # Search documentation
    pkgs.nix-doc              # Search docs & Generate tags + plugin
    pkgs.nix-du               # Show sizes of Nix store paths
    pkgs.nix-init             # Generate packages from URLs
    pkgs.nix-output-monitor
    pkgs.nix-tree             # Interactively view dep graphs of Nix derivations
    #pkgs.nix-query-tree-viewer # GUI to view Nix store path deps
    pkgs.pre-commit           # Git pre-commit hooks
    pkgs.vulnix               # Nix(OS) vulnerability scanner
  ];
  services.lorri.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
    # lib.mkIf config.programs.zsh.enable true;
  };
  nix.settings.plugin-files = [
    "${pkgs.nix-doc}/lib/libnix_doc_plugin.so"
    "${pkgs.nix-plugins}/lib/nix/plugins"
  ];

  # --- Config: nix.conf ---------------

  # --- Optimization -------------------
  nix.gc.automatic = true;                  # Collect garbage
  nix.optimise.automatic = true;            # Store optimizer
  nix.settings.auto-optimise-store = true;  # Dedup
  nix.settings.min-free = 128000000;
  nix.settings.max-free = 1000000000;
  nix.settings.keep-derivations = true;
  nix.settings.keep-env-derivations = false;
  nix.settings.keep-going = lib.mkDefault false;
  nix.settings.keep-outputs = lib.mkDefault true;
  nix.settings.preallocate-contents = lib.mkDefault true;

  # --- Registry -----------------------
  # Create Nix registry from nixpkgs
  # TODO: Select input based on system type
  nix.registry.nixpkgs.flake = inputs.nixpkgs;

  # --- Sandboxing ---------------------
  nix.settings.sandbox = true;   # Sandbox Nix builds
  nix.settings.fallback = true;  # Fallback to local build if substitute fails
  # Expose extra system paths to Nix build sandbox
  nix.settings.extra-sandbox-paths = [
  ];

  # --- Users --------------------------
  nix.settings.allowed-users = [ "*" ];
  nix.settings.trusted-users = [
    "root"
    "@wheel"
    "@builders"
    "sam"
  ];
  nix.settings.build-users-group = "nixbld";

  # --- Binary Cache -------------------
  nix.settings.builders-use-substitutes = true;  # Allow builders to use binary caches
  nix.settings.substituters = [
    "https://cache.nixos.org/"
    "https://nix-community.cachix.org/"
    "https://nix-on-droid.cachix.org/"
    "https://robotnix.cachix.org/"
    "https://nrdxp.cachix.org/"
    "https://numtide.cachix.org/"
    "https://snowflakeos.cachix.org/"
  ];
  nix.settings.trusted-substituters = [
    "https://hydra.nixos.org/"
    "https://nix-community.cachix.org/"
    "https://nix-on-droid.cachix.org/"
    "https://nrdxp.cachix.org/"
    "https://numtide.cachix.org/"
    "https://snowflakeos.cachix.org/"
  ];
  nix.settings.trusted-public-keys = [
    "hydra.nixos.org-1:CNHJZBh9K4tP3EKF6FkkgeVYsS3ohTl+oS0Qa8bezVs="
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "nix-on-droid.cachix.org-1:56snoMJTXmDRC1Ei24CmKoUqvHJ9XCp+nidK7qkMQrU="
    "nrdxp.cachix.org-1:Fc5PSqY2Jm1TrWfm88l6cvGWwz3s93c6IOifQWnhNW4="
    "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
  ];



  # --- Logging ------------------------
  nix.settings.keep-build-log = true;
  nix.settings.log-lines = 25;

  # --- Settings -----------------------
  nix.settings.connect-timeout = lib.mkDefault 10;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.warn-dirty = false;  # Warn git unstaged/uncommitted files

  #nix.settings.auto-allocate-uids = true;
  #nix.settings.experimental-features = ["auto-allocate-uids"];

  # --- Overlays -----------------------
  # Nix overlays are used to override packages
  nixpkgs.overlays = [
    inputs.nur.overlay
    (final: prev: { gnome-decoder = prev.gnome-decoder.overrideAttrs (attrs: {
      preBuild = ''
        export BINDGEN_EXTRA_CLANG_ARGS="$BINDGEN_EXTRA_CLANG_ARGS -DPW_ENABLE_DEPRECATED"
      '';
      meta.broken = false;
    }); })
  ];

  # --- Package Config -----------------
  nixpkgs.config.allowBroken = false;
  nixpkgs.config.allowUnfree = true;

  # --- Environment Variables ----------
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";

}
