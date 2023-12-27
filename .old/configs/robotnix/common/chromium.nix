
{ self, inputs, config, lib, pkgs,
  host, network, repo,
  ...
}:
let
  # --- Chromium Patchsets ---------------------------------
  patchsets = {
    disabled = [
      { repo = "https://github.com/stha09/chromium-patches"; disabled = "not android"; }
      { repo = "https://github.com/CatOS-Tiramisu/android_external_chromium-webview_patches";
        disabled = "Same as LineageOS";
        status.maintained = true;
      }
    ];

    enabled = [
      { name = "Vanadium";   id = "vanadium"; 
        repo = "https://github.com/GrapheneOS/Vanadium";
        patches = [ "patches/*.patch" ];
      }
      { name = "BeachOS";
        repo = "https://github.com/GrapheneOS/chromium_patches";
        patches = [
          { desc = "remove branding"; }
          { desc = "hide passwords.google.com"; }
          { desc = "disable welcome first run"; }
          { desc = "disable seed-based field trials"; }
          { desc = "disable navigation error correction"; }
          { desc = "disable contextual search by default"; }
          { desc = "disable network prediction"; }
          { desc = "disable metrics"; }
          { desc = "disable hyperlink auditing"; }
          { desc = "disable showiing popular sites"; }
          { desc = "disable article suggestions"; }
          { desc = "disable sensors access"; }
          { desc = "disable background sync"; }
          { desc = "disable payment support"; }
          { desc = "disable browser signin"; }
          { desc = "disable safe browsing"; }
          { desc = "local NTP"; }
          { desc = "set search engine to DDG"; }
          { desc = "add back trichrome APK targets"; }
          { desc = "remove fstring usage in build"; }
        ];
      }
      { name = "Brave";
        repo = "https://github.com/brave/brave-core";
        desc = "Brave browser w/ built-in ad blocking & more";
        dirs = [ "patches" "patches/third_party/catapult" "patches/third_party/devtools-frontend/src" "patches/v6" ];
        release = rec { file = "BraveMonox64.apk"; hash = "${file}.sha256"; sig = "${hash}.asc"; };
      }
      { name = "Bromite"; repo = "https://github.com/bromite/bromite"; }
      { name = "wchen342-android-extensions";
        repo = "https://github.com/wchen342/chromium-android-extension";
        desc = "Patches that add extension support to Chromium on Android";
        dirs = [ "patches/Extensions" "patches/Extensions/base" ];
        archived = true;
        updated = "20210303";
      }
      { name = "GrapheneOS"; id = "graphene";
        repo = "https://github.com/GrapheneOS/chromium_patches"; 
        maintained = true;
      }
      { name = "inox";  # Recommends using ungoogled-chromium
        repo = "";
        desc = "Disables data transmission to Google";
        status = { maintained = false; };
      }
      { name = "kiwi-browser";
        repo = "https://github.com/kiwibrowser/src.next";
        status.maintained = true;
      }
      { name = "kiwi-extension-patches";
        repo = "https://github.com/kiwibrowser/chromium_extension_patches";
        updated = "20200510";
      }
      { name = "kiwi-patches";
        repo = "https://github.com/kiwibrowser/patches";
        patches = [ "extension support" "remove AMP" "bottom bar"];
        updated = "20200122";
      }
      { name = "LineageOS";
        repo = "https://github.com/LineageOS/android_external_chromium-webview_patches";
        desc = "LineageOS patches. Handle theme color changes, higher-res webview icon, disable autofill server by default, disable webview variations support, disable component updater pings by default.";
        status.maintained = true;
      }
      { name = "Ungoogled Chromium";
        repo = "https://github.com/ungoogled-software/ungoogled-chromium";
        dirs = [ 
          "patches/core/bromite" "patches/core/debian/disable" "patches/core/inox-patchset" "patches/core/iridium-browser" "patches/core/ungoogled-chromium"
          "patches/extra/bromite" "patches/extra/debian/disable" "patches/extra/inox-patchset" "patches/extra/iridium-browser" "patches/extra/ungoogled-chromium"
        ];
        list = "patches/series";
        status = { maintained = true; };
      }

      { name = "Ungoogled Chromium Android";
        repo = "https://github.com/ungoogled-software/ungoogled-chromium-android";
        status = { maintained = true; };
      }

      { name = "xsmile";
        repo = "https://github.com/xsmile/ungoogled-chromium/tree/android";
        dirs = [ "patches/android" "patches/bromite" "patches/inox-patchset" "patches/iridium-browser" "patches/ungoogled-chromium" ];
        maintained = false; archived = false; updated = "20190417";
      }
      { name = "MoKee";
        repo = "https://github.com/MoKee/android_external_chromium-webview_patches";
        disabled = "Same as Lineage";
      }
      { name = "CalyxOS";
        repo = "https://github.com/CalyxOS/chromium-patches";
        disabled = "Same as GrapheneOS";
      }
      { name = "Iridium";
        repo = "https://github.com/iridium-browser/iridium-browser";
        patches = [ ];
      }
    ];
  };
in
{
  imports = [
  ];
}
