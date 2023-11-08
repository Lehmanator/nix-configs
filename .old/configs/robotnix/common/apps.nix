
{ self, inputs, config, lib, pkgs,
  host, network, repo,
  device ? "flame",
  oem    ? "google",
  ...
}:
let
  # --- Systen Applications ---------------------------------------
  # - TODO: NLP Backends
  #   - DejaVuNLPBackend
  #   - MozillaNLPBackend
  #   - AppleNLPBackend
  #   - RadioCellsNLPBackend

  # - TODO: Geocoder Backends
  #   - Nominatim Geocoder

  # - TODO: Camera Services Backend
  #   - [PixelCameraServicesFlame](https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_google_flame/-/blob/thirteen/proprietary/product/app/PixelCameraServicesFlame/PixelCameraServicesFlame.apk)
  # - [GcamServicesProvider](https://github.com/lukaspieper/Gcam-Services-Provider)

  # TODO: Search all ROMs for useful APKs
  # - [PixelExperience](https://gitlab.pixelexperience.org/android/vendor-blobs/vendor_google_flame)
  # - [ProtonAOSP](https://github.com/orgs/ProtonAOSP)

  # TODO: Wallpapers
  # - https://github.com/ProtonAOSP/android_packages_apps_ProtonWallpaperStub (Vendor Integration Commit: https://github.com/ProtonAOSP/android_vendor_proton/commit/e612f4e)

  # TODO: Magisk Modules
  # - https://github.com/topjohnwu/Magisk
  # - https://github.com/Displax/safetynet-fix
  # - https://github.com/kdrag0n/safetynet-fix  (Commits: https://github.com/ProtonAOSP/android_frameworks_base/commit/13dc7d28c12d   &   https://github.com/ProtonAOSP/android_frameworks_base/commit/a99ac1b48a9b    &    https://github.com/ProtonAOSP/android_device_google_coral/commit/8df17a36   &   https://github.com/ProtonAOSP/android_frameworks_base/commit/14cadef1690f   &   https://github.com/ProtonAOSP/android_vendor_proton/commit/29a394f    &    https://github.com/ProtonAOSP/android_system_core/commit/497ada563    &    https://github.com/ProtonAOSP/android_system_core/commit/497ada563)

  # TODO: launcher3 support grids: 6x6, 7x6, 7x7, 8x7, 8x8, 9x8, 9x9, 10x9
  # - See commit: https://github.com/GrapheneOS/platform_packages_apps_Launcher3/commit/7280712b20add31ab863df3c45229e9a3a97a2c6
  # - Sse files: 
  #   - res/xml/default_workspace_6x5.xml
  #   - res/xml/device_profiles.xml

  # --- User Applications ----------------------------------
  # - https://github.com/Yet-Zio/yetCalc
  user-apps = [
    "https://github.com/t184256/nix-in-termux"
    "https://github.com/t184256/nix-on-droid"
  ];

  # --- Chromium Patchsets ---------------------------------
  apps = let
    inherit device oem;
  in {
    disabled = [
    ];

    enabled = [
      { name = "CalyxOS";    id="calyx";
        repo = "https://github.com/CalyxOS/device_${oem}_${device}"; }
      { name = "GrapheneOS"; id="graphene";
        repo = ""; }
      { name = "DivestOS";   id="divest";
        repo = ""; }
      { name = "LineageOS";  id="lineage";
        repo = ""; }
      { name = "iodeOS";     id = "iode";
        repo = "https://gitlab.com/iode/os/public/devices/google/device_${oem}_${device}";
      }
    ];
  };
in
{ 
  imports = [];
}
