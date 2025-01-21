{ config, lib, ... }:
{
  nix = {
    # https://nix.dev/manual/nix/2.24/command-ref/new-cli/nix3-help-stores#experimental-ssh-store-with-filesystem-mounted
    extra-experimental-features = [
      # Allow the use of local overlay store.
      # https://nix.dev/manual/nix/2.24/command-ref/new-cli/nix3-help-stores#local-overlay-store
      # https://github.com/NixOS/nix/milestone/50
      "local-overlay-store"

      # Allow the use of the mounted SSH store.
      # https://nix.dev/manual/nix/2.24/command-ref/new-cli/nix3-help-stores#experimental-ssh-store-with-filesystem-mounted
      # https://github.com/NixOS/nix/milestone/43
      "mounted-ssh-store"

      # Allow the use of the read-only parameter in local store URIs.
      "read-only-local-store"
    ];

    # settings = {
    #   # base64-ssh-public-host-key = "";
    #   compress = false;
    #   max-connection-age = 4294967295;
    #   max-connections = 1;
    #   path-info-cache-size = 65536;
    #   priority = 0;
    #   real = "/nix/store";
    #   remote-program = "nix-daemon";
    #   remote-store = "auto";
    #   # mounted-ssh-ng://[username@]hostname
    #   # ssh-ng://[username@]hostname
    #   root = "";
    #   ssh-key = null;
    #   state = "/dummy";
    #   store = "/nix/store";
    #   trusted = false;         # TODO: true
    #   want-mass-query = false; # TODO: true
    # };
  };
}
