{ lib, config, pkgs, ... }:
{
  # https://gist.github.com/CMCDragonkai/810f78ee29c8fce916d072875f7e1751
  boot.initrd.availableKernelModules = [
    "coretemp" # Temperature monitoring on Intel CPUs
  ];

  #aesni_intel
  #i915                 3932160  59 kvmgt
  #input_leds             12288  0
  #intel_cstate           20480  0
  #intel_gtt              24576  1 i915
  #intel_pch_thermal      16384  0
  #intel_pmc_bxt          16384  1 iTCO_wdt
  #intel_pmc_core         81920  0
  #intel_powerclamp       16384  0
  #intel_rapl_common      36864  1 intel_rapl_msr
  #intel_rapl_msr         20480  0
  #intel_tcc_cooling      12288  0
  #intel_uncore          258048  0
  #iommufd                94208  1 vfio

}
