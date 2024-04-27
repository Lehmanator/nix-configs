{ config, ... }:
{
  nix = {
    sshServe = {
      enable = true;
      keys = [
        #"ssh-ed25519 AAAAC nix-ssh"
      ];
      protocol = "ssh";
      write = true;
    };
    settings.trusted-users = [ "nix-ssh" ];
  };
}
