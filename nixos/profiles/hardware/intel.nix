{ lib, config, pkgs, ... }:
{

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    opengl.extraPackages = [ pkgs.intel-media-driver pkgs.vaapiIntel pkgs.vaapiVdpau pkgs.libvdpau-va-gl ];
  };

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

  #aesni_intel           360448  2
  #agpgart                53248  2 intel_gtt,ttm
  #crc32c_intel           16384  2
  #cryptd                 28672  3 crypto_simd,ghash_clmulni_intel
  #crypto_simd            16384  1 aesni_intel
  #firmware_class         53248  8 snd_soc_avs,snd_hda_intel,xhci_pci_renesas,kvmgt,drm_display_helper,i915,cfg80211,drm
  #ghash_clmulni_intel    16384  0
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
  #kvm                  1335296  2 kvmgt,kvm_intel
  #kvm_intel             409600  0
  #libaes                 12288  1 aesni_intel
  #snd                   155648  11 snd_ctl_led,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_hda_codec,snd_hda_codec_realtek,snd_timer,snd_compress,snd_soc_core,snd_pcm
  #snd_hda_codec         217088  6 snd_hda_codec_generic,snd_soc_avs,snd_hda_codec_hdmi,snd_soc_hda_codec,snd_hda_intel,snd_hda_codec_realtek
  #snd_hda_core          143360  8 snd_hda_codec_generic,snd_soc_avs,snd_hda_codec_hdmi,snd_soc_hda_codec,snd_hda_intel,snd_hda_ext_core,snd_hda_codec,snd_hda_codec_realtek
  #snd_hda_intel          61440  0
  #snd_intel_dspcfg       36864  2 snd_soc_avs,snd_hda_intel
  #snd_intel_sdw_acpi     16384  1 snd_intel_dspcfg
  #snd_pcm               188416  8 snd_soc_avs,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_compress,snd_soc_core,snd_hda_core,snd_pcm_dmaengine
  #

}
