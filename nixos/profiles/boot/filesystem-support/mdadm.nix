{ inputs, config, lib, pkgs, modulesPath, ... }:
{
  imports = [
  ];

  # --- RAID Arrays ---
  boot.swraid = {
    enable = true;
    mdadmConf = ''
    '';
  };

}
