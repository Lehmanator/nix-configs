{ inputs
, config
, lib
, ...
}:
inputs.flake-utils.lib.eachDefaultSystem (system:
let
  pkgs = import inputs.nixpkgs { inherit system; };
in
rec {
  # --- Generic Devices ---
  packages.fastboot-flash-slot = pkgs.writeShellApplication {
    name = "fastboot-flash-slot";
    runtimeInputs = [ pkgs.android-tools ];
    text = ''
      slot="\$\{1:-a}"
      fastboot flash aop_$slot aop.img
      fastboot flash bluetooth_$slot bluetooth.img
      fastboot flash boot_$slot boot.img
      fastboot flash dsp_$slot dsp.img
      fastboot flash dtbo_$slot dtbo.img
      fastboot flash modem_$slot modem.img
      fastboot flash storsec_$slot storsec.img
      fastboot flash system_$slot system.img
      fastboot flash vbmeta_$slot vbmeta.img
      fastboot flash vendor_$slot vendor.img
      fastboot flash LOGO_$slot LOGO.img
    '';
  };

  # --- Pixel ---
  # TODO: Pixel flash GrapheneOS
  # TODO: Pixel restore default firmware
})
