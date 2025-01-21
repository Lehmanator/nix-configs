{ config, lib, pkgs
, inputs
, user
, ...
}:
# See:
# - https://discourse.nixos.org/t/mount-sshf-as-a-user-using-home-manager/32583/3
# - https://wiki.nixos.org/wiki/Rclone
let
  machines = builtins.attrNames inputs.self.nixosConfigurations;

  # TODO: Make this an exported lib
  getMachineConfigAttr = h: p: let
    path = if builtins.isList p then p else lib.splitString "." p;
  in lib.getAttrFromPath path inputs.self.nixosConfigurations.${h}.config;

  hostnames = builtins.map (h: getMachineConfigAttr h "networking.hostName") machines;
  fqdns     = builtins.map (h: getMachineConfigAttr h "networking.fqdn")     machines;

  # TODO: Get all keys from user=sam on all machines;
  keys = builtins.attrValues inputs.self.homeConfigurations;
  # machines = [ "fw" "wyse" "fajita0" "aio" ];
  
  mkMount = host: {
    fileSystems."/mnt/${host}" = {
      device = "${config.networking.hostName}@${host}.${config.networking.domain}:/home/${user}";
      # fsType = "sshfs";
      fsType = "fuse.sshfs";
      options = [
        "nodev"                # dont allow device files
        "noatime"              # disable access time
        "noauto"               # dont booting system without this mount
        "user"                 # allow manual mounting as ordinary user.
        "allow_other"          # dont restrict access to only the user who mounts it (probs systemd?)
        "x-systemd.automount"  # mount filesystem automatically on first access"
        "_netdev"              # network device
        "x-systemd.after=network-online.target"  # Wait until network up before attempting mount
        "IdentityFile=/etc/ssh/ssh_host_ed25519_key"
        # "IdentityFile=/root/.ssh/id_ed25519"
      ];
    };
  };
in
# TODO: Create sftp user, give permissions to SSH
# TODO: Configure hosts to accept each others' keys
# TODO: Configure self to work for other machines
{
  boot.supportedFilesystems."fuse.sshfs" = true;
  fileSystems = lib.lists.foldr mkMount {} machines; # TODO: Test
  users.extraUsers.sftp = {
    name = "${config.networking.hostName}-sftp";
    description = "SFTP user for machine: ${config.networking.hostName}";
    createHome = false;
    isSystemUser = true;
    openssh.authorizedPrincipals = lib.fold (item: acc: "sftp@${inputs.self.nixosConfigurations.}") [ "sftp@${config.networking.hostName}" ];
  };
}
