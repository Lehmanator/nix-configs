{ inputs, self
, config, lib, pkgs
, user ? "sam"
, ...
}:
# TODO: Make into NixOS profile
{
  imports = [
    inputs.snowflake.nixosModules.snowflake
  ];
  nix.settings.trusted-public-keys = [ "snowflakeos.cachix.org-1:gXb32BL86r9bw1kBiw9AJuIkqN49xBvPd1ZW8YlqO70=" ];

  environment.systemPackages = with inputs; [
    nix-software-center.packages.${pkgs.system}.nix-software-center
    nixos-conf-editor.packages.${pkgs.system}.nixos-conf-editor
    snow.packages.${pkgs.system}.snow
    pkgs.gitFull # For rebuiling with github flakes
  ];

  programs.nix-data = {
    systemconfig = "/home/${user}/.config/nixos/hosts/${config.networking.hostName}/configuration.nix";
    flake = "/etc/nixos/flake.nix";
    flakearg = "fw";
  };

  snowflakeos.gnome.enable = true;
  snowflakeos.osInfo.enable = true;
}
