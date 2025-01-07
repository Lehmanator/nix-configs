{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ ];

  # --- NVMe Support ---
  boot = {
    #availableKernelModules = ["sdhci_pci" "nvme"];
    kernelModules = [ "nvme" ];
    initrd = {
      availableKernelModules = [ "sdhci_pci" "nvme" ];
      includeDefaultModules = true;
      #kernelModules = ["sdhci_pci" "nvme"];
    };
  };

}
