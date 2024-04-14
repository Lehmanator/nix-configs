{ inputs, config, pkgs, ... }:
let inherit (pkgs) system;
in {
  imports = [ inputs.snowflake.nixosModules.snowflake ];

  snowflakeos = {
    gnome.enable = true;
    osInfo.enable = true;
  };

  nix.settings.trusted-public-keys =
    [ "snowflakeos.cachix.org-1:gXb32BL86r9bw1kBiw9AJuIkqN49xBvPd1ZW8YlqO70=" ];

  environment.systemPackages = [
    inputs.nix-software-center.packages.${system}.nix-software-center
    inputs.nixos-conf-editor.packages.${system}.nixos-conf-editor
    inputs.snow.packages.${system}.snow
    pkgs.gitFull # For rebuiling with github flakes
  ];
  programs.nix-data = {
    # TODO: Use inputs.self.nixosConfigurations.${config.networking.hostName}/configuration.nix
    systemconfig = "${toString ./configuration.nix}";
    flake = inputs.self; # "/etc/nixos/flake.nix";
    flakearg = config.networking.hostName; # "wyse";
  };
}
