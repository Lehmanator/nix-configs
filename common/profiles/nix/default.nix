{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  # TODO: Move NixOS-specific config to `../../nixos/nix/`
  imports = [
    ./cache
    ./features

    ./access-tokens.nix
    ./diff.nix
    ./documentation.nix
    ./gc.nix
    ./nixpkgs.nix
    ./optimize.nix
    ./overlays.nix
    ./registry.nix
    ./sandbox.nix
    ./shell.nix

    #./aliases.nix

    #./build/content-addressed.nix
    #./build/cross-compile.nix
    #./build/extra-outputs.nix
    #./build/logging.nix
    #./build/remote-builders.nix
    #./build/sandbox.nix

    #./cache/binary/personal.nix
    #./cache/binary/ssh-serve-store.nix
    #./cache/binary/upstream.nix
    #./cache/cachix/personal.nix
    #./cache/cachix/local-server.nix
    #./cache/compile/ccache.nix
    #./cache/compile/sccache.nix
    #./cache/compile/distccache.nix

    #./features/channel-disable.nix
    #./features/command.nix
    #./features/flakes.nix
    #./features/plugins.nix
    #./features/registry.nix
    #./features/repl.nix
    #./features/recursive.nix

    #./nixpkgs/allow-broken.nix
    #./nixpkgs/allow-unfree.nix
    #./nixpkgs/overlays

    #./optimize/dedup.nix
    #./optimize/garbage-collection.nix

    #./shell/alias.nix
    #./shell/completion.nix
    #./shell/nix-path.nix
    #./shell/linters.nix
    #./shell/updaters.nix
  ];

  # --- Config: nix.conf ---------------
  nix = {
    # Disable `nix-channel` command & state files are made available on the machine.
    # TODO: Is the nix registry the successor to this functionality?
    # - `/nix/var/nix/profiles/per-user/root/channels`
    # - `/root/.nix-channels`
    # - `$HOME/.nix-defexpr/channels`
    channel.enable = false;

    # --- Packages -----------------------
    # Use Nix package manager package with builtin flakes support
    package =
      pkgs.nixUnstable; # pkgs.nixFlakes; #(nixUnstable for use-xdg-base-directories, nixFlakes for flakes support)

    settings = {
      use-xdg-base-directories = true;

      # --- Users --------------------------
      allowed-users = ["*"];
      trusted-users = ["root" "@wheel" "@builders" user];
      build-users-group = lib.mkDefault "nixbld";

      keep-build-log = lib.mkDefault true;
      log-lines = lib.mkDefault 25;
      connect-timeout = lib.mkDefault 10;
      warn-dirty = lib.mkDefault false; # Warn git unstaged/uncommitted files

      # Expose extra system paths to Nix build sandbox
      extra-sandbox-paths = [];

      # --- Nix Plugins --------------------
      #plugin-files = [
      #  "${pkgs.nix-doc}/lib/libnix_doc_plugin.so"
      #  "${pkgs.nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so"
      #];
    };
  };
}
