{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    homeManagerIntegration = lib.mkDefault true;
    autoImport = lib.mkDefault true;
  };
}
