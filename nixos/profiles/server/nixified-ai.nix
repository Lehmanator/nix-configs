{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault mkIf;
in {
  imports = with inputs.nixified-ai.nixosModules; [invokeai textgen];
  networking.firewall.allowedTCPPorts = with config.services.invokeai; mkIf enable [config.services.invokeai.settings.port];
  services.invokeai = {
    enable = mkDefault true;
    group = mkDefault "invokeai";
    user = mkDefault "invokeai";
    settings = {
      host = mkDefault "127.0.0.1";
      port = mkDefault 9090;
      root = mkDefault "/var/lib/invokeai";
      precision = mkDefault "auto"; # auto | float32 | autocast | float16
    };
  };
}
