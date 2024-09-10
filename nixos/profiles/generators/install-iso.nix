{ inputs, config, lib, pkgs, user, ... }:
{
  imports = [ inputs.disko.nixosModules.disko ];

  formatConfigs = rec {
    install-iso = { inputs, config, lib, pkgs, ... }: {
      disko.enableConfig = false;
      nix.package = pkgs.lix;
      nix.settings.experimental-features = [ "nix-command" "flakes"];
      users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        openssh.authorizedKeys.keys = config.users.users.${user}.openssh.authorizedKeys.keys;
      };
      services.openssh = {
        enable = true;
        extraConfig = ''
          MaxAuthTries 600
        '';
      };
      environment.systemPackages = with inputs.disko.packages.${pkgs.system}; [ disko disko-doc ];
    };
    #install-iso-hyperv = install-iso // { };
    #iso = { };
  };
}
