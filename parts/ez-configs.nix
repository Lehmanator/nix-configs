{
  inputs,
  self,
  ...
}: {
  imports = [inputs.ez-configs.flakeModule];

  # TODO: Restructure dirs
  ezConfigs = {
    globalArgs = {
      inherit inputs;
      user = "sam";
    };
    home = {
      configurationsDirectory = "../hm/users";
      modulesDirectory = "../hm/modules";
    };
    nixos = {
      modulesDirectory = "../nixos/profiles";
      configurationsDirectory = "../nixos/hosts";
    };
    darwin = {
      modulesDirectory = "../darwin/profiles";
      configurationsDirectory = "../darwin/hosts";
    };
  };
}
