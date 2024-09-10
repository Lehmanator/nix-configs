{ inputs, lib, pkgs, user, ... }: {
  imports = [
    inputs.lix-module.nixosModules.default
    ./access-tokens.nix
    ./ccache.nix
    ./diff.nix
    ./documentation.nix
    ./features.nix
    ./gc.nix
    ./nixpkgs.nix
    ./optimize.nix
    ./overlays.nix
    ./shell.nix
    # ./aliases.nix
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
    checkConfig = true;
    daemonCPUSchedPolicy = lib.mkDefault "idle";
    daemonIOSchedClass = lib.mkDefault "idle";
    # daemonIOSchedPriority = lib.mkDefault 4;
    distributedBuilds = lib.mkDefault true;

    package = lib.mkDefault pkgs.lix;
    settings = {

      allow-import-from-derivation = true;
      allowed-users     = ["*"];
      trusted-users     = ["root" "@wheel" "@builders" user];
      build-users-group = lib.mkDefault "nixbld";
      keep-build-log    = lib.mkDefault true;
      log-lines         = lib.mkDefault 25;
      connect-timeout   = lib.mkDefault 10;
      warn-dirty        = lib.mkDefault false;

      # --- Flakes ---
      accept-flake-config = true;
      experimental-features = ["nix-command" "flakes"];
      extra-experimental-features = ["fetch-closure" "recursive-nix"]
        ++ lib.optionals pkgs.stdenv.isLinux ["auto-allocate-uids" "cgroups"]
      ;
      system-features = lib.mkIf pkgs.stdenv.isLinux ["uid-range"];
      auto-allocate-uids = lib.mkIf pkgs.stdenv.isLinux true;
      use-cgroups = lib.mkIf pkgs.stdenv.isLinux true;
      use-xdg-base-directories = lib.mkIf pkgs.stdenv.isLinux true;
      
      # --- Sandboxing ---
      sandbox = true;
      fallback = true;
      extra-sandbox-paths = [];
    };
  };
}
