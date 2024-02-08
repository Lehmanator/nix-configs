{lib, ...}: {
  generate-host-rules = {
    config,
    user,
    ...
  }:
    lib.generators.toYAML {
      # sops decryption key list
      keys = [
        # HostKey: SSH RSA     -> GPG key      (ssh-to-pgg) -> GPG fingerprint
        # HostKey: SSH ed25519 -> age key pair (ssh-to-age) -> age public key
      ];
      creation_rules = let
        configuration-types = [
          "common"
          "darwin"
          "droid"
          "liminix"
          "linux"
          "nixos"
          "robotnix"
          "wsl"
        ];
        # Illegal paths:
        #
        # Paths words can only have one dot in a row:      `file..name.ext`,  `..filename.ext`,  `filename..ext`
        # Paths words must have at least one alnum char:  `../filename.ext`,  `./filename.ext`,  `parent/./filename.ext`
        # Paths words must end with alnum char:              `filename.ext.`, `a/filename.ext-`, `filename./`
        # Paths cannot have two consec forward-slashes:   `a//filename.ext`,
        #
        # Legal Paths:
        # Path words can start with a dot if len>1: `.hidden.file`
        #
        regex-filename-prefix = "(.?(([a-z]|[A-Z]|[0-9])+[|.-_]?)+)?";
        configurations-regex = "(${lib.lists.concatStringsSep "|" configuration-types})";
        file-extensions = [
          "asc"
          "auth.*"
          "bin"
          "ce?rt"
          "cfg"
          "co?nf(ig)?"
          "creds?"
          "env"
          "ini"
          "json"
          ".*keys?"
          "luks"
          "pass(w(or)?d)?"
          "pwd"
          "priv.*"
          "pub"
          "secrets?"
          "toml"
          "yaml"
        ];
        #regex-extension = "(" + (lib.lists.concatStringsSep "|" file-extensions) + ")$";
        #regex-path-word = "[^/]+";
        #regex-filename = regex-path-word + "\." + regex-extension;
        #regex-nested-dirs = "(" + regex-path-word + "/)+";
        #regex-filepath-flat = regex-path-word + "/" + regex-filename;
        #regex-filepath-nested = regex-nested-dirs + "/" + regex-filename;
        #path-filename-regex = regex-path-word + "/" + regex-path-word + "\." + regex-extension;
        #path-subdir-regex = "(" + path-word-regex + "/)+";
        #path-nested-file-regex = path-subdir-regex + "/" + path-filename-regex;
        #path-single-dir-file-regex = "path";
        #file-path-subdir-regex = "(" + path-word-regex + "/)+";
        #file-path-regex = file-path-subdir-regex + path-word-regex + "\." + file-extensions-regex + "$";
        #secret-path-host-shared = configurations-regex + "/secrets/" + file-path-regex;
        #secret-path-host-profile = configurations-regex + "/(profiles|suites)/" + file-path-regex;
      in [
        {
          path_regex = "(common|darwin|droid|nixos|robotnix|wsl)/secrets(/[^/]+)+.(ya?ml|json|env|ini|bin|.*key|luks|asc|pem|.*ce?rt)$";
        }
      ];
    };
}
