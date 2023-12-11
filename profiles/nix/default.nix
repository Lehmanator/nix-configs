{ inputs
, config
, lib
, pkgs
, user
, ...
}:
# TODO: Split config into:
# - [ ] TODO: Nix Build - Cross Compilation
# - [ ] TODO: Nix Build - Settings
# - [ ] TODO: Nix Cache - Binary cache + Trusted Keys
# - [ ] TODO: Nix Cache - Cachix
# - [ ] TODO: Nix Cache - Local cache
# - [ ] TODO: Nix Flakes
# - [ ] TODO: Nix Git API access-tokens
# - [ ] TODO: Nix Logging
# - [ ] TODO: Nix Registry
# - [ ] TODO: Nix Shell Aliases
# - [ ] TODO: Nix Shell Utils
# - [ ] TODO: Nix Store Optimization / Garbage Collection
{
  imports = [
    ../documentation.nix
    ./access-tokens.nix
    ./aliases.nix
    ./binary-caches.nix
    #./ca-derivations.nix
    ./ccache.nix
    ./features.nix
    ./flakes.nix
    ./gc.nix
    #./nix-path.nix
    ./nixpkgs.nix
    ./optimize.nix
    ./overlays.nix
    ./registry.nix
    ./sandbox.nix
    ./shell.nix
    #./ssh-serve-store.nix
    ./utils.nix
  ];

  # --- Packages -----------------------
  # Use Nix package manager package with builtin flakes support
  nix.package = pkgs.nixUnstable; #pkgs.nixFlakes; #(nixUnstable for use-xdg-base-directories, nixFlakes for flakes support)

  # Disable `nix-channel` command & state files are made available on the machine.
  # TODO: Is the nix registry the successor to this functionality?
  # - `/nix/var/nix/profiles/per-user/root/channels`
  # - `/root/.nix-channels`
  # - `$HOME/.nix-defexpr/channels`
  nix.channel.enable = false;

  # --- Config: nix.conf ---------------
  nix.settings = {
    use-xdg-base-directories = lib.mkDefault true;

    # --- Users --------------------------
    allowed-users = [ "*" ];
    trusted-users = [ "root" "@wheel" "@builders" user ];
    build-users-group = lib.mkDefault "nixbld";

    keep-build-log = lib.mkDefault true;
    log-lines = lib.mkDefault 25;
    connect-timeout = lib.mkDefault 10;
    warn-dirty = lib.mkDefault false; # Warn git unstaged/uncommitted files

    # Expose extra system paths to Nix build sandbox
    extra-sandbox-paths = [ ];

    # --- Nix Plugins --------------------
    #plugin-files = [
    #  "${pkgs.nix-doc}/lib/libnix_doc_plugin.so"
    #  "${pkgs.nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so"
    #];
  };

  # --- Nix Outputs --------------------
  environment.extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];

}
