{
  config,
  lib,
  pkgs,
  user,
  ...
}: {
  # TODO: Inherit from default
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${user}" = {
    isNormalUser = true;
    description = lib.mkIf (user == "sam") "Sam Lehman";

    # TODO: Migrate to more standard "username:username"
    # TODO: Create new "users" group & add primary user.
    group = "users";
    extraGroups = ["dialout" "wheel" "sshd"];

    # Format: <options> <keyType> <base64-encoded-key> <comment>
    #    See: http://man.he.net/man5/authorized_keys
    # TODO: Collect from flake outputs? Filter out duplicates & prevent infinite recursion.
    # TODO: Only `ed-25519 keys`?
    # TODO: Purpose-specific keys?
    #  - TODO: KDE Connect
    #  - TODO: Backup
    #  - TODO: Remote builders
    openssh.authorizedKeys.keys = lib.mkIf (user == "sam") [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCn5m9GuM7DgUwKEienhfXC38a2UTWCCHsXwJSeOeXaNegYeHcPMp1NTwJ04CV6YwXUzVjehyOtDFVQ7XvnwsjOYAK1suYIw5tt2LeejTk4cYnnplHEmoxvQuc6tLK62w3/ar+Ba6OEJdf+9Mv0uJSEYliX9sF/PPce3YrdMKYesn75qyU0xvnfDTsEyXh6ldwMUfLiviY/yfYWAyOPX2LoBWskpLtsPNVQm5Fyjqzm/CjKlv2ILZm5BH6PjLb+wa1bgk0aSFcx82CNVgY7Bh9aWnN+yzbIIzn4VSHOVV/RWQk8OfIZ3F2HBJ+OPZq3fEa9PVIGNCBmzjUxlTcofcNAeVc0LAbqV5PUwhKayCS1Lh3ehUNf83+L0hle4FYtvWu84GoQRf/0OmhOiVeaK6xmvNL7zSoWurTWlMCs9FZxPGMRb5KdmOqhHjGNd82tyGYGNkykzAgs14BZvmd4h0w7J98k5UOsF0a6fZnA3AQQwfQdrB4fKsuxGoWt4pD47UQ3KjO71OwYsVREvkkeRKnYMbV3zJ2SPRU1NoL2ZgptRdRjyFu5HqXndUwoEcgWT1FC5NQqj+r0PYyRzS7qMyHG9T2KvYd3jDXZNDYUvTGJfKvf2TDJ2m2Ix001go/68EdbdpRkVRMPoi2gg/K/WbvOwhDAaRh8a+A/0JfMNoo3vQ== termux@cheetah"
      # TODO:  "ssh-ed25519  u0_a263@localhost"  # Flame   (Termux)
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHoHifjJL0fMBZDjNnXvSDhr0cwgkU80ybVeKRnly7Ku termux@cheetah" # Cheetah (Termux)
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICtA7S/6BSsGRTTcKU/9+Aa/VsPCJzNkfjHbvFlaSVKN user@fajita-gnome" # Fajita  (gnome)
      # +--[Hostname]--+--------[OS]--+--[Env]--+-------[OEM]--+--[Model Name]----+--[Codename]--+
      # | fw           |        NixOS | GNOME   |      Samsung | Galaxy S21 Ultra |              |
      # | wyse         |        NixOS | GNOME   |         Dell | Wyse 7040        |              |
      # | aio          |        NixOS | GNOME   |         Dell | Inspiron AIO     |              |
      # | raspi3       |        NixOS | Server  | Raspberry Pi | Raspberry Pi 3   |              |
      # | taba8        | PostmarketOS | GNOME   |      Samsung | Galaxy Tab A 8.0 |              |
      # | fajita-gnome | PostmarketOS | GNOME   |      OnePlus | 6T               | fajita       |
      # | fajita-phosh | PostmarketOS | Phosh   |      OnePlus | 6T               | fajita       |
      # | oriole       |      Android | Termux  |       Google | Pixel 6          | oriole       |
      # | raven        |      Android | Termux  |       Google | Pixel 6 Pro      | raven        |
      # | flame        |      Android | Termux  |       Google | Pixel 4          | flame        |
      # | taimen       |      Android | Termux  |       Google | Pixel 2 XL       | taimen       |
      # | sultra       |      Android | Termux  |      Samsung | Galaxy S21 Ultra |              |
      # +--------------+--------------+---------+---------------------------------+--------------+
    ];
  };

  # users = {
  #   groups = {
  #     nm-openconnect = {};
  #     #netdev = {};
  #   };
  #   #extraGroups = {
  #   #  # Fix for D-Bus error on missing group: netdev
  #   #  # TODO: Figure out what causes this error (sshd? pkcs? pam? pam-pkcs11?)
  #   #  netdev = { name = "netdev"; };
  #   #};
  #   extraUsers = {
  #     # Fix for D-Bus error on missing user: nm-openconnect
  #     # TODO: Figure out what causes this error (sshd? pkcs? pam? pam-pkcs11? OpenConnect? NetworkManager?)
  #     nm-openconnect = {
  #       name = "nm-openconnect";
  #       description = "System user to control OpenConnect in NetworkManager";
  #       isSystemUser = true;
  #       group = "nm-openconnect";
  #       extraGroups = [
  #         #"netdev"
  #         "networkmanager"
  #       ];
  #     };
  #   };
  # };
}
