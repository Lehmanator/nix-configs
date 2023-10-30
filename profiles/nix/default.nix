{ self , inputs
, config , lib , pkgs
, user ? "sam"
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
    #./ca-derivations.nix
    ./cache.nix
    ./ccache.nix
    ./features.nix
    ./flakes.nix
    ./gc.nix
    ./nixpkgs.nix
    ./optimize.nix
    ./registry.nix
    ./sandbox.nix
    ./shell.nix
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
    extra-sandbox-paths = [
    ];

    # --- Nix Plugins --------------------
    #plugin-files = [
    #  "${pkgs.nix-doc}/lib/libnix_doc_plugin.so"
    #  "${pkgs.nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so"
    #];
  };

  # --- Nix Outputs --------------------
  environment.extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];

  # --- Nix Path -----------------------
  # https://nixos.wiki/wiki/Flakes
  # Note: channels & nixPath are legacy, but still often used by tooling
  environment.etc = {
    "nix/inputs/nixpkgs".source          = inputs.nixpkgs.outPath;
    #"nix/inputs/nixpkgs-stable".source   = inputs.nixpkgs-stable.outPath;
    #"nix/inputs/nixpkgs-unstable".source = inputs.nixpkgs-unstable.outPath;
    #"nix/inputs/nixpkgs-staging".source  = inputs.nixpkgs-staging.outPath;
    #"nix/inputs/nixpkgs-master".source   = inputs.nixpkgs-stable.outPath;

    "nix/inputs/nixos".source            = inputs.nixos.outPath;
    #"nix/inputs/nixos-stable".source     = inputs.nixos-stable.outPath;
    #"nix/inputs/nixos-unstable".source   = inputs.nixos-unstable.outPath;
    #"nix/inputs/nixos-staging".source    = inputs.nixos-staging.outPath;
    #"nix/inputs/nixos-master".source     = inputs.nixos-stable.outPath;
  };
  nix.nixPath = [
    "nixpkgs=/etc/nix/inputs/nixpkgs"
    #"nixpkgs-stable=/etc/nix/inputs/nixpkgs-stable"
    #"nixpkgs-unstable=/etc/nix/inputs/nixpkgs-unstable"
    #"nixpkgs-staging=/etc/nix/inputs/nixpkgs-staging"
    #"nixpkgs-master=/etc/nix/inputs/nixpkgs-master"
    #"nixpkgs-gnome=/etc/nix/inputs/nixpkgs-gnome"

    "nixos=/etc/nix/inputs/nixos"
    #"nixos-stable=/etc/nix/inputs/nixos-stable"
    #"nixos-unstable=/etc/nix/inputs/nixos-unstable"
    #"nixos-staging=/etc/nix/inputs/nixos-staging"
    #"nixos-master=/etc/nix/inputs/nixos-master"
    #"nixos-gnome=/etc/nix/inputs/nixos-gnome"

    #"nixos-config=/etc/nixos/configuration.nix"
  ];
  #nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  #nix.nixPath = let path = toString ./.; in [ "repl=${path}/repl.nix" "nixpkgs=${inputs.nixpkgs}" ];



}
