{
  inputs,
  osConfig,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.agenix.homeManagerModules.default
    inputs.agenix-rekey.homeManagerModules.default
  ];
  age = {
    rekey = {
      storageMode = "local";
      hostPubkey = inputs.self + /nixos/hosts/${osConfig.networking.hostName}/ssh_host_ed25519_key.pub;
      cacheDir = "$XDG_CACHE_HOME/agenix-rekey";
      localStorageDir = inputs.self + /hm/users/${config.home.username}/secrets;
      extraEncryptionPubkeys = ["age1aazux953qlqlzpfvvnhtlz0qr866ae3gve9wcskj394gq9ax0pvqca44qu"];
      masterIdentities = [
        {
          identity = inputs.self + /hm/users/${config.home.username}/privkey.age;
          pubkey = "age13p3t3hl7uk2k5alq0p0j62kghh7926vlcts2hjl0vcy70ggjqcwscpk0ul";
        }
        (inputs.self + /hm/users/${config.home.username}/id_ed25519.pub)
      ];
    };
  };
}
