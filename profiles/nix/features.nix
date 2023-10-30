{ self, inputs, lib, config, pkgs, ... }:
{
  # --- Experimental Features ---
  # See: https://nixos.org/manual/nix/stable/contributing/experimental-features#xp-feature-auto-allocate-uids
  # auto-allocate-uids = true;  # Allow Nix to automatically pick UIDs for builds, rather than creating `nixbld*` user accounts
  # ca-derivations = true;      # Allow derivations to be content-addressed in order to prevent rebuilds when changes to the derivation do not result in changes to the derivation's output. See: https://nixos.org/manual/nix/stable/language/advanced-attributes#adv-attr-__contentAddressed
  # cgroups = true;             # Allow Nix to execute builds inside cgroups. See the `use-cgroups` setting. https://nixos.org/manual/nix/stable/contributing/experimental-features#conf-use-cgroups
  # daemon-trust-override = false; # Allow forcing trusting/not-trusting clients w/ nix-daemon.
  # dynamic-derivations = true;    # Allow use of "text hashing" derivation outputs, to build `.drv` files. Deps in derivations on the outputs of derivations that are themselves derivations outputs
  # fetch-closure = true;          # Allow use of the `fetchClosure` builtin function in the Nix language.
  # flakes = true;                 # Enable flakes
  # impure-derivations = false;    # Allow derivations to product non-fixed outputs by setting the `__impure` derivation attr = `true`.
  # nix-command = true;            # Enable new `nix` subcommands.
  # no-url-literals = false;       # Disallow unquoted URLs as part of Nix language syntax.
  # parse-toml-timestamps = true;  # Allow parsing of timestamps in `builtins.fromTOML`
  # read-only-local-store = true;  # Allow the use of the `read-only` parameter in local store URIs.
  # recursive-nix = true;          # Allow derivation builders to call Nix, thus building derivations recursively.
  # repl-flake = true;             # Allow passing installables to `nix repl`, making its interface consistent w/ other experimental commands.
  nix.settings.experimental-features = [
    "dynamic-derivations"
    "parse-toml-timestamps"
    "read-only-local-store"
    "recursive-nix"
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    "auto-allocate-uids"
    "cgroups"
  ];
  nix.settings.auto-allocate-uids = lib.mkDefault pkgs.stdenv.isLinux;
}
