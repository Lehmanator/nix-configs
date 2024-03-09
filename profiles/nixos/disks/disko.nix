{ inputs, pkgs, ... }: {
  imports = [ inputs.disko.nixosModules.disko ];
  environment.systemPackages = with inputs.disko.packages.${pkgs.system}; [ disko disko-doc ];
}
