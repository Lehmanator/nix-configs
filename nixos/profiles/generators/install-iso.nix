{ inputs, config, lib, pkgs, user, ... }:
{
  imports = [
    # inputs.nixos-generators.nixosModules.all-formats
    inputs.nixos-generators.nixosModules.install-iso
    (inputs.self + /nixos/profiles/disko.nix)
  ];

  formatConfigs = {
    #iso = { };
    #install-iso-hyperv = install-iso // { };
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
  };
}
