{
  inputs,
  self,
  ...
}: {
  imports = [inputs.ez-configs.flakeModule];
  ezConfigs = {
    globalArgs = {
      inherit inputs self;
      user = "sam";
    };
    home = {
      configurationsDirectory = "../../users";
      modulesDirectory = "../../modules/hm";
      extraSpecialArgs = {};
    };
    nixos = {
      modulesDirectory = "../../modules/nixos";
      configurationsDirectory = "../../hosts";
      hosts = {fajita = {system = "aarch64-linux";};};
    };
    darwin = {
      modulesDirectory = "../../modules/darwin";
      configurationsDirectory = "../../hosts/darwin";
    };
  };
}
