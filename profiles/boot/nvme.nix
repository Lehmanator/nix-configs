{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ ];

  # --- NVMe Support ---
  boot = {
    #availableKernelModules = ["sdhci_pci" "nvme"];
    kernelModules = [ "sdhci_pci" "nvme" ];
    initrd = {
      availableKernelModules = [ "sdhci_pci" "nvme" ];
      includeDefaultModules = true;
      #kernelModules = ["sdhci_pci" "nvme"];
    };
  };

}
