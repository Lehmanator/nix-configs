{ inputs, lib, pkgs, user, ... }: 
let
  inherit (lib) mkDefault mkIf optionals;
  inherit (pkgs.stdenv) isLinux;
in
{
  imports = [
    inputs.lix-module.nixosModules.default
    ./access-tokens.nix
    ./ccache.nix
    ./diff.nix
    ./documentation.nix
    ./gc.nix
    ./nixpkgs.nix
    ./optimize.nix
    ./overlays.nix
    ./shell.nix
    # ./aliases.nix
    # ./features.nix
    #./build/{content-addressed,cross-compile,extra-outputs,logging,remote-builders,sandbox}.nix
    #./cache/binary/{personal,upstream,ssh-serve-store}.nix
    #./cache/cachix/{personal,local-server}.nix
    #./cache/compile/{ccache,sccache,distccache}.nix
    #./features/{channel-disable,command,flakes,plugin,registry,repl,recursive}.nix
    #./nixpkgs/{allow-broken,allow-unfree,overlays}.nix
    #./optimize/{dedup,gc}.nix
    #./shell/{alias,completion,nix-path,linters,updaters}.nix
  ];

  nix = {
    enable = true;
    channel.enable = false;
    checkAllErrors = true;
    checkConfig    = true;
    daemonCPUSchedPolicy = mkDefault "idle";
    daemonIOSchedClass   = mkDefault "idle";
    # daemonIOSchedPriority = mkDefault 4;
    distributedBuilds    = mkDefault true;

    package = mkDefault pkgs.lix;
    settings = {
      allow-import-from-derivation = true;
      allowed-users     = ["*"];
      trusted-users     = ["root" "@wheel" "@builders" user];
      build-users-group = mkDefault "nixbld";
      keep-build-log    = mkDefault true;
      log-lines         = mkDefault 25;
      connect-timeout   = 5;  # set=4 in srvos.nixosModules.common.nix 
      warn-dirty        = mkDefault false;

      # --- Flakes ---
      accept-flake-config = true;
      experimental-features = [
        "nix-command" "flakes" "ca-derivations" "recursive-nix"
      ] ++ optionals isLinux ["auto-allocate-uids" "cgroups"]
      ;
      extra-experimental-features = [
        "dynamic-derivations"
        "fetch-closure"
        "parse-toml-timestamps" "read-only-local-store"
        "impure-derivations"
        "pipe-operators"
      ];
      substituters        = ["https://cache.ngi0.nixos.org/"];  # content-address derivations cache
      trusted-public-keys = ["cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="];
      system-features = ["big-parallel" "nixos-test" "benchmark" "ca-derivations"] ++ optionals isLinux ["cgroups" "uid-range" "kvm"];
      auto-allocate-uids       = mkIf isLinux true;
      use-cgroups              = mkIf isLinux true;
      use-xdg-base-directories = mkIf isLinux true;
      use-registries           = true;
      
      # --- Sandboxing ---
      sandbox = true;
      fallback = true;
      extra-sandbox-paths = [];
    };
  };

  # --- Experimental Features ---
  #
  # See: https://nixos.org/manual/nix/stable/contributing/experimental-features#xp-feature-auto-allocate-uids
  #
  # auto-allocate-uids = true; #     # Allow Nix to automatically pick builder UIDs, rather than creating `nixbld*` user accounts
  # ca-derivations = true; #         # Allow content-addressed derivations. Prevent rebuild if derivation changes dont affect output (https://nixos.org/manual/nix/stable/language/advanced-attributes#adv-attr-__contentAddressed)
  # cgroups = true; #                # Allow Nix to execute builds inside cgroups. See setting: `use-cgroups` (https://nixos.org/manual/nix/stable/contributing/experimental-features#conf-use-cgroups)
  # daemon-trust-override = false; # # Allow forcing trusting/not-trusting clients w/ nix-daemon.
  # dynamic-derivations = true; #    # Allow "text hashing" derivation outputs, to build `.drv` files. Deps in derivations on the outputs of derivations that are themselves derivations outputs
  # fetch-closure = true; #          # Allow use of the `fetchClosure` builtin function in the Nix language.
  # flakes = true; #                 # Enable flakes
  # git-hashing = true; #            # Allow creating (content-addressed) store objects hashed via Git's hashing algo.
  # impure-derivations = false; #    # Allow derivations to produce non-fixed outputs by setting derivation attr: `__impure=true`
  # mounted-ssh-store = false; #     # Allow use of the mounted SSH store (https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-help-stores#experimental-ssh-store-with-filesytem-mounted)kj
  # nix-command = true; #            # Enable new `nix` subcommands.
  # no-url-literals = false; #       # Disallow unquoted URLs as part of Nix language syntax.
  # parse-toml-timestamps = true; #  # Allow parsing of timestamps in `builtins.fromTOML`
  # read-only-local-store = true; #  # Allow the use of the `read-only` parameter in local store URIs.
  # recursive-nix = true; #          # Allow derivation builders to call Nix, thus building derivations recursively.
  # verified-fetches = true; #       # Enables verification of git commit signatures through the fetchGit built-in.
  #
  # --- Docs ---
  # https://nixos.wiki/wiki/Ca-derivations
  # https://www.tweag.io/blog/2020-09-10-nix-cas/
  # https://edolstra.github.io/pubs/phd-thesis.pdf#page=143
  # https://discourse.nixos.org/t/tweag-nix-dev-update-12/13185/3
  # nixpkgs.config.contentAddressedByDefault = lib.mkDefault false;


}
