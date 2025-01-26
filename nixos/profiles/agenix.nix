{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}:
# Agenix CLI uses file `./secrets.nix` to determine keys used to encrypt data.
#
#  - This file is not controlled by your system's Nix config, but is read by the CLI directly.
#      This is limiting because we cannot reference values from system configs.
#
#  - However, the file path used by `agenix` can be set using the `RULES` environment variable.
#    So we can use this to dynamically adjust our `secrets.nix` file.
#      Ideas:
#      - Use `direnv` to set the `RULES` env var upon changing into subdirectories
#      - Write shell script to wrap `agenix` w/ `RULES` set according to the argument file path.
#      - Write shell script to wrap `agenix` w/ `cd` command into dir w/ the argument file path & use separate `secrets.nix` files.
#        - `agenix() { echo $1 | cut -d '/' -f1 | xargs cd`
#      - Import Nix configs nested deeper in the file tree.
#
# Set env var `RULES` to specify path to `./secrets.nix`
{
  imports = [
    inputs.agenix.nixosModules.default
    inputs.agenix-rekey.nixosModules.default
  ];
  # home-manager.sharedModules = [
  #   (inputs.self + /hm/profiles/agenix.nix)
  #   # inputs.agenix.homeManagerModules.default
  #   # inputs.agenix-rekey.homeManagerModules.default
  # ];

  age = {
    # TODO: Replace with `rage`? (rust age CLI util)
    ageBin = lib.mkDefault (lib.getExe pkgs.age);

    identityPaths = lib.mkDefault [
      "/var/lib/persistent/ssh_host_ed25519_key"
      "/nix/persist/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_ed25519_key"
    ];
    #secretsDir = lib.mkDefault "/run/agenix";
    #secretsMountPoint = lib.mkDefault "/run/agenix.d";

    rekey = {
      storageMode = "local";

      # The local storage directory for rekeyed secrets.
      # MUST be a path inside of your repository,
      # & it MUST be constructed by concatenating to the root directory of your flake.
      # Follow the example.
      localStorageDir = inputs.self + /nixos/hosts/${config.networking.hostName}/secrets;
      cacheDir = "$XDG_CACHE_HOME/agenix-rekey";

      # https://github.com/oddlama/agenix-rekey?tab=readme-ov-file#agerekeyhostpubkey
      # The age public key to use as a recipient when rekeying.
      # This either has to be the path to an age public key file,
      # #or the public key itself in string form.
      hostPubkey = inputs.self + /nixos/hosts/${config.networking.hostName}/ssh_host_ed25519_key.pub;

      # https://github.com/oddlama/agenix-rekey?tab=readme-ov-file#agerekeymasteridentities
      # List: age identities used by rage when decrypting stored secrets to rekey them for hosts.
      # If multiple identities are given, they will be tried in-order.
      # TODO: Add YubiKey (or similar hardware key)
      masterIdentities = [
        {
          identity = ./hm/users/sam/privkey.age;
          pubkey = "age13p3t3hl7uk2k5alq0p0j62kghh7926vlcts2hjl0vcy70ggjqcwscpk0ul";
        }
        (inputs.self + /hm/users/${user}/id_ed25519.pub)
        "/home/${user}/.ssh/id_ed25519.pub"
        "/home/${user}/.config/age/host.pub"
        "/home/${user}/.config/sops/age/"
      ];

      # Using `agenix edit FILE`, file encrypted for all identities in `age.rekey.masterIdentities` by default.
      # Here, specify an extra set of pubkeys for which all secrets should also be encrypted.
      # Useful in case you want to have a backup identity that must be able to decrypt all secrets but should not be used when attempting regular decryption.
      extraEncryptionPubkeys = ["age1aazux953qlqlzpfvvnhtlz0qr866ae3gve9wcskj394gq9ax0pvqca44qu"];
    };
  };

  environment.etc = {
    "ssh/ssh_host_ed25519_key.pub".source = inputs.self + /nixos/hosts/${config.networking.hostName}/ssh_host_ed25519_key.pub;
    "ssh/ssh_host_rsa_key.pub".source = inputs.self + /nixos/hosts/${config.networking.hostName}/ssh_host_rsa_key.pub;
  };
}
