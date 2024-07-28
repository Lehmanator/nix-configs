{ config, lib, pkgs, ... }: {
  # https://nixos.wiki/wiki/Ca-derivations
  # https://www.tweag.io/blog/2020-09-10-nix-cas/
  # https://edolstra.github.io/pubs/phd-thesis.pdf#page=143
  # https://discourse.nixos.org/t/tweag-nix-dev-update-12/13185/3
  # nixpkgs.config.contentAddressedByDefault = lib.mkDefault false;

  nix.settings = {
    extra-experimental-features = [
      "ca-derivations"
      "dynamic-derivations"
      "fetch-closure" "parse-toml-timestamps" "read-only-local-store"
      #"git-hashing" # Note: Allow creating (content-addressed) store objects which are hashed via Git's hashing algorithm. These store objects will not be understandable by older versions of Nix.
      "impure-derivations" "configurable-impure-env"
      "recursive-nix"
      "verified-fetches"
    ];
    extra-substituters        = ["https://cache.ngi0.nixos.org/"]; # content-address derivations cache
    extra-trusted-public-keys = ["cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA="];
  };

  # --- Experimental Features ---
  # See: https://nixos.org/manual/nix/stable/contributing/experimental-features#xp-feature-auto-allocate-uids
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
}
