{ config, lib, pkgs, ... }:
# NOTE: Home Manager systemd units are not like NixOS systemd units.
# NOTE: Home Manager systemd units attrs follow systemd naming/capitalization.
# j9oRo3iHKygIKuQc0dF6OOkyhA8M2S9bOY6f7C4PgxE=
let
  mkMount = host: 
  {
    # NOTE: Unit name must match mount path
    # NOTE: Replace / with - in mount paths
    mounts."home-${config.home.username}-.local-${host}" = {
      Unit = {
        Description = "SSHFS: ${host} -> ${config.home.homeDirectory}/.local/mnt/${host}";
        Before = "remote-fs.target";
      };
      Install.WantedBy = ["remote-fs.target" "multi-user.target"];
      Mount = {
        What="${config.home.username}@${host}:${config.home.homeDirectory}";
        Where="${config.home.homeDirectory}/.local/mnt/${host}";
        Type = "fuse.sshfs";
        Options = lib.concatStringsSep "," [
          "_netdev" "rw" "nosuid" "allow_other"
          "uid=1000" "gid=1000"
          "default_permissions"
          "follow_symlinks"
          "idmap=${config.home.homeDirectory}"
          "identityfile=${config.home.homeDirectory}/.ssh/id_ed25519"
        ];
      };
    };

    # NOTE: Automount unit name must match Mount unit name
    automounts."home-${config.home.username}-.local-${host}" = {
      enable = true;
      name = "home-${config.home.username}-.local-${host}";
      Unit.Description = "SSHFS: ${host} -> ${config.home.homeDirectory}/.local/mnt/${host}";
      Install.WantedBy = ["multi-user.target"];
      Automount = {
        Where = "${config.home.homeDirectory}/.local/mnt/${host}";
        TimeoutIdleSec = 0;
      };
    };
  };
in
{
  systemd.user.mount = {
    
  };
}
