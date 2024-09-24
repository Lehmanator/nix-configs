{ config, lib, pkgs, ... }: {
  imports = [
    ./access-tokens.nix
    ./binary-caches.nix
    ./write-config.nix
    #./nix.nix
    #./nixpkgs.nix
  ];

  nix.package = lib.mkDefault pkgs.lix;
  home = {
    extraOutputsToInstall = ["bin"]; # [ "doc" "info" "devdoc" "dev" "bin" ];
    sessionVariables.NIX_BIN_DIR = "${config.nix.package}/bin";
    shellAliases = 
    let
      clip-bin = "${pkgs.wl-clipboard}/bin/wl-paste";
    #   mkAliasPrefix = pre: lib.lists.foldr (item: acc: acc // { "${item}" = "${pre} ${item}"; }) {};
    #   baseCommands = mkAliasPrefix "nix" [
    #     "build" "bundle" "derivation" "develop" "doctor"
    #     "flake" "fmt" "help-stores" "nar" "path-info"
    #     "print-dev-env" "profile" "run" "search" "shell"
    #     "store" "realisation" "repl" "upgrade-nix" "why-depends"
    #   ];
    #   flakeCommands = mkAliasPrefix "nix flake" ["check" "clone" "init" "lock" "metadata" "new" "prefetch" "show" "update"];
    #   storeCommands = mkAliasPrefix "nix store" ["add-file" "add-path" "cat" "copy-logs" "copy-sigs" "delete" "diff-closures" "dump-path" "gc" "ls" "make-content-addressed" "optimise" "path-from-hash-part" "ping" "prefetch-file" "repair" "sign" "verify"];
    in rec
    {
      # --- Nix CLI ------------------------------
      # TODO: Create lib to shorten this
      # --- Base Commands ---
      # Remove `nix ` prefix from subcommands
      build       = "nix build";
      bundle      = "nix bundle";
      derivation  = "nix derivation";
      develop     = "nix develop";
      doctor      = "nix doctor";
      flake       = "nix flake";
      fmt         = "nix fmt";
      help-stores = "nix help-stores";
      nar         = "nix nar";
      path-info   = "nix path-info";
      print-dev-env = "nix print-dev-env";
      profile     = "nix profile";
      run         = "nix run";
      search      = "nix search";
      shell       = "nix shell";
      store       = "nix store";
      realisation = "nix realisation";
      repl        = "nix repl";
      upgrade-nix = "nix upgrade-nix";
      why-depends = "nix why-depends";

      # These commands might conflict with existing commands.
      # config = "nix config";
      # copy   = "nix copy";
      # daemon = "nix daemon";
      # edit   = "nix edit";
      # eval   = "nix eval";
      # hash   = "nix hash";
      # key    = "nix key";
      # log    = "nix log";

      # --- Flake Commands ---
      # Remove `nix flake ` prefix from flake subcommands
      check    = "nix flake check";
      clone    = "nix flake clone";
      init     = "nix flake init";
      lock     = "nix flake lock";
      metadata = "nix flake metadata";
      new      = "nix flake new";
      prefetch = "nix flake prefetch";
      show     = "nix flake show";
      update   = "nix flake update --commit-lock-file";

      # --- Other Subcommands ---
      config-show = "nix config show";

      # --- Renamed Commands ---
      # Commands that cannot be simply aliased without `nix ` prefix.
      nedit = "nix edit";
      nenv  = "nix env";
      nrun  = "nix run";
      # TODO: FZF pname selection for this?
      # npkg = "nix run nixpkgs#$(read -p \"Enter a package name\")";

      # --- Nix Store -------------------------
      store-optimize = "nix store optimise";
      store-gc       = "nix store gc --verbose";
      store-cleanup  = "nix store gc & nix store optimise &";
      store-content-addressed = "nix store make-content-addressed";
      make-content-addressed  = store-content-addressed;
      
      # --- Dependencies -------------------------
      nix-closure-list = "nix-store -qR `which $1`"; # TODO: Figure out how to allow
      nix-closure-tree = "nix-store -q --tree `which $1`"; # arg not at end of alias
      nix-dependencies = "nix-store -q --references `which $1`";
      nix-dependencies-reverse = "nix-store -q --referrers `which $1`";

      # --- Flakes -------------------------------
      nf   = "nix flake";
      nfs  = "nix flake show";
      nfsp = "nix flake show git+$(${clip-bin})";
    };
  };

  # xdg.configFile = let
  #   mkRegistryJSON = reg: builtins.toJSON { version = 2; flakes = lib.mapAttrsToList (n: v: {inherit (v) from to exact;}) reg; };
  # in lib.recursiveUpdate {
  #   "nix/registry.json".text = mkRegistryJSON osConfig.nix.registry or config.nix.registry;
  # } (lib.mapAttrs' (name: value: {
  #   name = "nix/inputs/${name}";
  #   value = {source = value.outPath;};
  # }) inputs);

  # Keep legacy nix-channels in sync w/ flake inputs (for tooling compat)
  # TODO: Same for NixOS, conditionally if system is NixOS
  #xdg.configFile = let
  #  hmReg = mkRegistryJSON config.nix.registry; # osConfig.nix.registry;
  #in lib.recursiveUpdate { "nix/registry.json".text = hmReg; }
  #{(lib.mapAttrs' (n: v: { n = "nix/inputs/${n}"; v = { source = v.outPath; }; }) inputs);
}
