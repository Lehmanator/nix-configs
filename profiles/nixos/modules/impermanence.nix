{
  inputs,
  pkgs,
  user,
  ...
}: {
  imports = [inputs.impermanence.nixosModules.impermanence];

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      # TODO: Caches
      # TODO: Containers
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      "/etc/machine-id"
      #{ file = "/etc/nix/id_rsa"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];

    users.${user} = {
      directories = [
        "Backup"
        "Books"
        "Code"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Templates"
        "Videos"

        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".nixops";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ".local/share/direnv"
        ".mozilla"
        ".pki"
        ".kube"
      ];
    };
  };

  # Enable impermanence for home-manager too.
  home-manager.sharedModules = [inputs.impermanence.homeManagerModules.impermanence];
}
