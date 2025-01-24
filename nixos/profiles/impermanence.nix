{
  inputs,
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      # TODO: Caches
      # TODO: Containers
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
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
        "Audio"
        "Backup"
        "Books"
        "Code"
        "Documents"
        "Downloads"
        "Games"
        "Music"
        "Nix"
        "Pictures"
        "Templates"
        "Videos"

        # --- Keys ---
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ".pki"
        # --- NixOps ---
        {
          directory = ".nixops";
          mode = "0700";
        }
        # --- Flatpaks ---
        ".var/app"
        ".local/share/flatpak"

        # --- Direnv ---
        ".local/share/direnv"

        # --- Mozilla ---
        ".mozilla"

        # --- Kubernetes ---
        ".kube"
      ];
    };
  };

  # Enable impermanence for home-manager too.
  # TODO: Move to hm/profiles/impermanence.nix
  home-manager.sharedModules = [ inputs.impermanence.homeManagerModules.impermanence ];
}
