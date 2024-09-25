{ inputs, config, lib, pkgs, user, ... }:
let
  # TODO: Allso add SSH keys to host, enable user sftpman, ...
  mkHostMounts = attrs: lib.concatMapAttrs (host: v: {
    "${host}" = {
      authType = "publickey";
      host = v.config.networking.hostName;
      mountPoint = config.home.homeDirectory + "/.mounts/" + host;
      port = 22;         # TODO: v.config.services.openssh.port
      user = "sftpman";  # TODO: v.config.services.openssh.allowUsers
      mountOptions = [];
    };
  }) attrs.nixosConfigurations;
in
{
  programs.sftpman = {
    enable = true;
    defaultSshKey = "~/.ssh/id_ed25519";
    mounts = mkHostMounts inputs.self;
    # mounts = {
    #   wyse = {
    #     authType = "publickey";
    #     host = "wyse.${config.networking.domain}";
    #     mountPoint = "/home/${user}/.mounts/${config.networking.hostName}";
    #     port = "22";
    #     # sshKey = ""
    #     # user = config.networking.hostName;
    #     user = "sftpman";
    #     mountOptions = [
    #     ];
    #   };
    # };
  };
}
