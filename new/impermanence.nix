{ inputs, self
, pkgs, lib, config
, user ? "sam"
, ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      { directory="/var/lib/colord"; user="colord"; group="colord"; mode="u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file="/etc/nix/id_rsa";     parentDirectory={mode="u=rwx,g=,o=";}; }
      { file="/etc/nix/id_ed25519"; parentDirectory={mode="u=rwx,g=,o=";}; }
    ];
  };

  users.mutableUsers = false;
  users.users.${user}.passwordFile = "/persist/etc/user-passwd/${user}"; #config.sops.secrets."user-${user}.passwd".file;

}
