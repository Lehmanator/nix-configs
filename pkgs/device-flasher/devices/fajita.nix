{ inputs
, self
, ...
}:
inputs.flake-utils.lib.eachDefaultSystem (system:
let
  pkgs = import inputs.nixpkgs { inherit system; };
  partitions = {
    critical = [ "aop" "bluetooth" "dsp" "qupfw" "storsec" ]; # Partitions considered critical & usually flash locked by default.
    oem = [ "fw_4jled" "fw_4ulea" "oem_stanvbk" "storsec" "qupfw" "vendor" ]; # Partitions exclusive to device/OEM
    generic = [ "boot" "dtbo" "modem" "oem_stanvbk" "storsec" "system" "vbmeta" "vendor" "LOGO" ]; # Partitions for all Android phones.
    a11 = [ "abl" "cmnlib" "cmnlib64" "devcfg" "hyp" "keymaster" "reserve" "xbl" "xbl_config" ]; # Partitions exclusive to Android 11
  };
  # https://www.getdroidtips.com/oneplus-6t-stock-firmware-collections/
  # https://droidwin.com/restore-oneplus-6-stock-via-fastboot-commands/
  images = {
    ota = {
      boot = "https://ava3.androidfilehost.com/dl/XDrlro_ETqTmI8zM0KPTZw/1698177164/11410963190603865988/OnePlus6TOxygen_34_OTA_013_all_1811270327_boot.img"; # OOS 9.0.7 (Android 11)
      all = "https://oxygenos.oneplus.net/OnePlus6TOxygen_34.J.62_OTA_0620_all_2111252336_f6eda340d7af4e3e.zip"; # OOS 11.1.2.2 (security patch 2021.11) (Jan 26th 2022)
    };
  };
in
rec {
  # --- OnePlus 6T ---
  # TODO: Figure out which images are exclusive to device
  # TODO: Create variant for devices without A/B partitioning
  # TODO: Create variant for dual-booting Linux & Android
  # TODO: Download OEM stock firmware, extract, & cd into new dir

  packages.fajita-flash-oem = pkgs.writeShellApplication {
    name = "fajita-flash-oem";
    runtimeInputs = [ pkgs.android-tools pkgs.payload-dumper-go ];
    text = ''
      slot="\$\{1:-a}"
      fastboot flash fw_4jled_$slot fw_4jled.img
      fastboot flash fw_4ulea_$slot fw_4ulea.img
      fastboot flash modem_$slot modem.img
      fastboot flash oem_stanvbk_$slot oem_stanvbk.img
      fastboot flash qupfw_$slot qupfw.img
      fastboot flash vendor_$slot vendor.img
      fastboot flash LOGO_$slot LOGO.img
    '';
  };
  packages.fajita-flash-all = pkgs.writeShellApplication {
    name = "fajita-flash-all";
    runtimeInputs = [
      pkgs.android-tools # ADB & Fastboot
      pkgs.payload-dumper-go
      #pkgs.fastboot
    ];
    text = ''
      slot="\$\{1:-a}"
      fastboot -w   # Wipe user data
      if [[ slot == "both" ]]; then
        fajita-flash-oem a
        fastboot-flash-slot a
        fajita-flash-oem b
        fastboot-flash-slot b
      else
        fajita-flash-oem $slot
        fastboot-flash-slot $slot
      fi
      fastboot reboot

      #fastboot flash abl_a abl.img
      #fastboot flash abl_b abl.img
      #fastboot flash cmnlib_a cmnlib.img
      #fastboot flash cmnlib_b cmnlib.img
      #fastboot flash cmnlib64_a cmnlib64.img
      #fastboot flash cmnlib64_b cmnlib64.img
      #fastboot flash devcfg_a devcfg.img
      #fastboot flash devcfg_b devcfg.img
      #fastboot flash hyp_a hyp.img
      #fastboot flash hyp_b hyp.img
      #fastboot flash keymaster_a keymaster.img
      #fastboot flash keymaster_b keymaster.img
      #fastboot flash reserve_a reserve.img
      #fastboot flash reserve_b reserve.img
      #fastboot flash xbl_a xbl.img
      #fastboot flash xbl_b xbl.img
      #fastboot flash xbl_config_a xbl_config.img
      #fastboot flash xbl_config_b xbl_config.img


      #fastboot flash aop_a aop.img
      #fastboot flash aop_b aop.img
      #fastboot flash bluetooth_a bluetooth.img
      #fastboot flash bluetooth_b bluetooth.img
      #fastboot flash boot_a boot.img
      #fastboot flash boot_b boot.img
      #fastboot flash dsp_a dsp.img
      #fastboot flash dsp_b dsp.img
      #fastboot flash dtbo_a dtbo.img
      #fastboot flash dtbo_b dtbo.img
      #fastboot flash fw_4jled_a fw_4jled.img
      #fastboot flash fw_4jled_b fw_4jled.img
      #fastboot flash fw_4ulea_a fw_4ulea.img
      #fastboot flash fw_4ulea_b fw_4ulea.img
      #fastboot flash modem_a modem.img
      #fastboot flash modem_b modem.img
      #fastboot flash oem_stanvbk_a oem_stanvbk.img
      #fastboot flash oem_stanvbk_b oem_stanvbk.img
      #fastboot flash qupfw_a qupfw.img
      #fastboot flash qupfw_b qupfw.img
      #fastboot flash storsec_a storsec.img
      #fastboot flash storsec_b storsec.img
      #fastboot flash system_a system.img
      #fastboot flash system_b system.img
      #fastboot flash vbmeta_a vbmeta.img
      #fastboot flash vbmeta_b vbmeta.img
      #fastboot flash vendor_a vendor.img
      #fastboot flash vendor_b vendor.img
      #fastboot flash LOGO_a LOGO.img
      #fastboot flash LOGO_b LOGO.img
    '';
  };
  # TODO: Fajita convert to international version
  packages.fajita-convert-international = pkgs.writeShellApplication {
    name = "fajita-convert-international";
    runtimeInputs = [ pkgs.android-tools pkgs.payload-dumper-go ];
    text = ''
      slot="\$\{1:-a}"
    '';
  };
  # TODO: Fajita flash PostmarketOS-only
  # TODO: Fajita flash PostmarketOS (dual-boot)
  # TODO: Fajita flash LineageOS
  # TODO: Fajita flash TWRP recovery
})
