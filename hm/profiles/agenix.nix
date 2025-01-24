{
  inputs,
  osConfig,
  config,
  lib,
  pkgs,
  ...
}:
let
  dirs = {
    host =
      inputs.self + /nixos/hosts/${osConfig.networking.hostName or "/etc/ssh/ssh_host_ed25519_key.pub"};
    user = inputs.self + /hm/users/${config.home.username};
  };
  secretDir = "${dirs.host}/secrets";
  keys = {
    host = {
      ed25519 = "${dirs.host}/ssh_host_ed25519_key.pub";
      rsa = "${dirs.host}/ssh_host_rsa_key.pub";
    };
    user = {
      ed25519 = "${dirs.user}/id_ed25519.pub";
      rsa = "${dirs.user}/id_rsa.pub";
    };
  };
in
{
  imports = [
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
  ];
  age = {
    rekey = {
      storageMode = "local";
      cacheDir = "$XDG_CACHE_HOME/agenix-rekey";
      localStorageDir = secretDir;
      extraEncryptionPubkeys = [ "age1aazux953qlqlzpfvvnhtlz0qr866ae3gve9wcskj394gq9ax0pvqca44qu" ];
      masterIdentities = [
        {
          identity = "${dirs.user}/privkey.age";
          pubkey = "age13p3t3hl7uk2k5alq0p0j62kghh7926vlcts2hjl0vcy70ggjqcwscpk0ul";
        }
        keys.user.ed25519
      ];
    };
  };
}
