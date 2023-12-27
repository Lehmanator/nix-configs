{ inputs
, config
, lib
, pkgs
, user
, ...
}:
{
  imports = with inputs.nixified-ai.nixosModules; [ invokeai textgen ];
  services.invokeai = {
    enable = lib.mkDefault true;
    group = lib.mkDefault "invokeai";
    user = lib.mkDefault "invokeai";
    settings = {
      host = lib.mkDefault "127.0.0.1";
      port = lib.mkDefault 9090;
      root = lib.mkDefault "/var/lib/invokeai";
      precision = lib.mkDefault "auto"; # auto | float32 | autocast | float16
    };
  };

  environment.persistence."/nix/persist".directories = lib.mkIf config.services.invokeai.enable [ "/var/lib/invokeai" ];

}
