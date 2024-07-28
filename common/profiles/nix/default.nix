{ lib, pkgs, user, ... }: {
  imports = [
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
    channel.enable = lib.mkDefault false;
    package = lib.mkDefault pkgs.nixVersions.latest;
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
      
      # --- Sandboxing ---
      sandbox = true;
      fallback = true;
      extra-sandbox-paths = [];
    } // lib.optionalAttrs pkgs.stdenv.isLinux {
      auto-allocate-uids = true;
      use-xdg-base-directories = true;
      use-cgroups = true;
      extra-experimental-features = ["auto-allocate-uids" "cgroups"];
    };
  };
}
