{ inputs, config, lib, pkgs, ... }:
let gpu-oem = "amd"; # "nvidia"
in {
  imports = [
    inputs.nixified-ai.nixosModules.invokeai
    #inputs.nixified-ai.nixosModules.textgen
  ];
  services.invokeai = {
    enable = lib.mkDefault true;

    package = lib.mkDefault
      inputs.nixified-ai.packages.${pkgs.system}."invokeai-${gpu-oem}";
    group = lib.mkDefault "invokeai";
    user = lib.mkDefault "invokeai";
    settings = {
      host = lib.mkDefault "127.0.0.1";
      port = lib.mkDefault 9090;
      root = lib.mkDefault "/var/lib/invokeai";
      precision = lib.mkDefault "auto"; # auto | float32 | autocast | float16
    };
  };

  # TODO: Conditional if module enabled
  #environment.persistence."/nix/persist".directories = lib.mkIf config.services.invokeai.enable [ "/var/lib/invokeai" ];
}
