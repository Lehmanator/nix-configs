{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ inputs.snowflake.nixosModules.snowflake ];
  nix.settings.trusted-public-keys = [ "snowflakeos.cachix.org-1:gXb32BL86r9bw1kBiw9AJuIkqN49xBvPd1ZW8YlqO70=" ];

  environment.systemPackages = [
    inputs.nix-software-center.packages.${pkgs.system}.nix-software-center
    inputs.nixos-conf-editor.packages.${pkgs.system}.nixos-conf-editor
    inputs.snow.packages.${pkgs.system}.snow
    pkgs.gitFull # For rebuiling with github flakes
  ];
  programs.nix-data = {
    systemconfig = "${toString ./configuration.nix}";
    flake = "/etc/nixos/flake.nix";
    flakearg = "wyse";
  };
  snowflakeos.gnome.enable = true;
  snowflakeos.osInfo.enable = true;

}
