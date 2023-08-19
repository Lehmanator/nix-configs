{ self , inputs
, config , lib , pkgs
, user ? "sam"
, ...
}:
# TODO: Split config into:
# - [ ] TODO: Nix Build - Cross Compilation
# - [ ] TODO: Nix Build - Settings
# - [ ] TODO: Nix Logging
# - [ ] TODO: Nix Shell Aliases
# - [ ] TODO: Nix Shell Utils
# - [ ] TODO: Nix Cache - Cachix
# - [ ] TODO: Nix Cache - Local cache
let
  primaryUser = "sam";
in
{
  imports = [
    ../documentation.nix
    ./access-tokens.nix
    ./cache.nix
    ./flakes.nix
    ./nixpkgs.nix
    ./optimize.nix
    ./registry.nix
    ./sandbox.nix
    ./shell.nix
  ];

  nix.settings.use-registries = true;
  nix.settings.flake-registry = true;

  # --- Nix Outputs --------------------
  environment.extraOutputsToInstall = [ "doc" "info" "devdoc" "dev" "bin" ];

  # --- Nix Path -----------------------
  # https://nixos.wiki/wiki/Flakes
  # Note: channels & nixPath are legacy, but still often used by tooling
  environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  nix.nixPath = [ "nixpkgs=/etc/nix/inputs/nixpkgs" ];
  #nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  #nix.nixPath = let path = toString ./.; in [ "repl=${path}/repl.nix" "nixpkgs=${inputs.nixpkgs}" ];

  # --- Nix Plugins --------------------
  #nix.settings.plugin-files = [
  #  "${pkgs.nix-doc}/lib/libnix_doc_plugin.so"
  #  "${pkgs.nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so"
  #];

  # --- Config: nix.conf ---------------
  nix.settings.use-xdg-base-directories = true;

  # --- Users --------------------------
  nix.settings.allowed-users = [ "*" ];
  nix.settings.trusted-users = [ "root" "@wheel" "@builders" primaryUser ];
  nix.settings.build-users-group = "nixbld";

  nix.settings.keep-build-log = true;
  nix.settings.log-lines = 25;

  # --- Settings -----------------------
  nix.settings.connect-timeout = lib.mkDefault 10;
  nix.settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];
  nix.settings.warn-dirty = false; # Warn git unstaged/uncommitted files

  #nix.settings.auto-allocate-uids = true;
  #nix.settings.experimental-features = ["auto-allocate-uids"];

}
