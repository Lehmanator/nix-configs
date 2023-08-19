{ self , inputs
, config , lib , pkgs
, user ? "sam"
, ...
}:
# TODO: Split config into:
# - [ ] TODO: Nix Build - Cross Compilation
# - [ ] TODO: Nix Build - Settings
# - [ ] TODO: Nix Flakes
# - [ ] TODO: Nix Git API access-tokens
# - [ ] TODO: Nix Logging
# - [ ] TODO: Nix Registry
# - [ ] TODO: Nix Shell Aliases
# - [ ] TODO: Nix Shell Utils
# - [ ] TODO: Nix Store Optimization / Garbage Collection
# - [ ] TODO: Nix Cache - Binary cache + Trusted Keys
# - [ ] TODO: Nix Cache - Cachix
# - [ ] TODO: Nix Cache - Local cache
# - [ ] TODO: Nixpkgs config
let
  primaryUser = "sam";
in
{
  imports = [
    inputs.nix-quick-registry.nixosModules.local-registry
    ./documentation.nix
    #./nix/access-tokens.nix
    #./nix/cache.nix
    #./nix/flakes.nix
    #./nix/nixpkgs.nix
    #./nix/optimize.nix
    #./nix/registry.nix
    #./nix/sandbox.nix
    #./nix/shell.nix
  ];

  # --- Nix Registry ---------------------------------------
  # User: ~/.config/nix/registry.json
  # Create Nix registry from nixpkgs
  # TODO: Select input based on system type
  #nix.registry.nixpkgs.flake = inputs.nixpkgs;
  nix.registry = {
    nixos.flake = inputs.nixos;
    darwin.flake = inputs.darwin;
    #repo = {
    #  to = { type = "github"; owner = "PresqueIsleWineDev"; repo = "nix-configs"; };
    #};
  };
  nix.localRegistry = {
    enable = true;
    cacheGlobalRegistry = true;
    noGlobalRegistry = false;
  };
  nix.settings.use-registries = true;
  nix.settings.flake-registry = true;

  # --- Packages -----------------------
  # Use Nix package manager package with builtin flakes support
  nix.package = lib.mkDefault pkgs.nixUnstable; #pkgs.nixFlakes; #(nixUnstable for use-xdg-base-directories, nixFlakes for flakes support)
  environment.extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];

  # https://nixos.wiki/wiki/Flakes
  # Note: channels & nixPath are legacy, but still often used by tooling
  environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  nix.nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
  #nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  #nix.nixPath = let path = toString ./.; in [ "repl=${path}/repl.nix" "nixpkgs=${inputs.nixpkgs}" ];

  #nix.settings.plugin-files = [
  #  "${pkgs.nix-doc}/lib/libnix_doc_plugin.so"
  #  "${pkgs.nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so"
  #];

  # --- Config: nix.conf ---------------
  nix.settings.accept-flake-config = true;
  nix.settings.use-xdg-base-directories = true;

  # --- Optimization -------------------
  nix.gc = {
    automatic = true; # Collect garbage
    options = "--cores 1 --max-freed 100G --max-jobs 1 --timeout 30 --delete-older-than 30d"; # Limit garbage collection to 100GB using 1 concurrent job on 1 core, & 30 seconds of runtime
    dates = "weekly";
  };
  nix.optimise.automatic = true; # Store optimizer
  nix.settings.auto-optimise-store = true; # Dedup
  nix.settings.min-free = 128000000;
  nix.settings.max-free = 1000000000;
  nix.settings.keep-derivations = true;
  nix.settings.keep-env-derivations = false;
  nix.settings.keep-going = lib.mkDefault false;
  nix.settings.keep-outputs = lib.mkDefault true;
  nix.settings.preallocate-contents = lib.mkDefault true;

  # --- Sandboxing ---------------------
  nix.settings.sandbox = true; # Sandbox Nix builds
  nix.settings.fallback = true; # Fallback to local build if substitute fails
  # Expose extra system paths to Nix build sandbox
  nix.settings.extra-sandbox-paths = [
  ];

  # --- Users --------------------------
  nix.settings.allowed-users = [ "*" ];
  nix.settings.trusted-users = [ "root" "@wheel" "@builders" primaryUser ];
  nix.settings.build-users-group = "nixbld";

  # --- Binary Cache -------------------
  nix.settings.builders-use-substitutes = true; # Allow builders to use binary caches
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
  nix.settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];
  nix.settings.warn-dirty = false; # Warn git unstaged/uncommitted files

  #nix.settings.auto-allocate-uids = true;
  #nix.settings.experimental-features = ["auto-allocate-uids"];

  # TODO: Make secret via agenix / sops-nix
  # TODO: Replace after making secret
  nix.settings.access-tokens = [
    "github.com=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"
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

  # --- Environment --------------------
  environment = {
    sessionVariables.NIXPKGS_ALLOW_UNFREE = lib.mkIf config.nixpkgs.config.allowUnfree "1";

    # --- Utils ----------------------------------------------
    # TODO: Remove pkgs that are imported elsewhere
    shellAliases = let
      flakeDir = "~/.config/nixos";
    in rec {
      cfgd     = "cd ${flakeDir}";
      ndoc = "manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
      n        = "nix";
      nb       = "${n} build";
      build    = "${n} build";
      develop  = "${n} develop";
      registry = "${n} registry";
      neval    = "${n} eval";
      flake    = "${n} flake";    nf = "${n} flake";
      profile  = "${n} profile";
      repl     = "${n} repl";
      run      = "${n} run";
      store    = "${n} store";
    };
    systemPackages = [
      pkgs.cachix # CLI for cachix binary caches
      pkgs.deadnix # Find dead code in Nix configs
      pkgs.manix # Search documentation
      pkgs.nix-doc # Search docs & Generate tags + plugin
      pkgs.nix-plugins # Misc Nix plugins
      pkgs.nix-du # Show sizes of Nix store paths
      pkgs.nix-init # Generate packages from URLs
      pkgs.nix-output-monitor
      pkgs.nix-tree # Interactively view dep graphs of Nix derivations
      pkgs.nix-update # Update Nix packages
      #pkgs.nix-query-tree-viewer # GUI to view Nix store path deps
      pkgs.nurl # Automatically generate fetcher expressions from URLs
      pkgs.nvfetcher # Update package commits & hashes
      pkgs.pre-commit # Git pre-commit hooks
      pkgs.vulnix # Nix(OS) vulnerability scanner
    ];

  };
}
