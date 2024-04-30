{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
  {
    "aw-watcher-web" = buildFirefoxXpiAddon {
      pname = "aw-watcher-web";
      version = "0.4.7";
      addonId = "{ef87d84c-2127-493f-b952-5b4e744245bc}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4094303/aw_watcher_web-0.4.7.xpi";
      sha256 = "f26d76c9fbc8efd8e9752f271aa58bd7447fda9521f47812eaa9d304a612d0c0";
      meta = with lib;
      {
        homepage = "https://github.com/ActivityWatch/aw-watcher-web";
        description = "This extension logs the current tab and your browser activity to ActivityWatch.";
        license = licenses.mpl20;
        platforms = platforms.all;
        };
      };
    "imagus" = buildFirefoxXpiAddon {
      pname = "imagus";
      version = "0.9.8.74";
      addonId = "{00000f2a-7cde-4f20-83ed-434fcb420d71}";
      url = "https://addons.mozilla.org/firefox/downloads/file/3547888/imagus-0.9.8.74.xpi";
      sha256 = "2b754aa4fca1c99e86d7cdc6d8395e534efd84c394d5d62a1653f9ed519f384e";
      meta = with lib;
      {
        homepage = "https://tiny.cc/Imagus";
        description = "With a simple mouse-over you can enlarge images and display images/videos from links.";
        platforms = platforms.all;
        };
      };
    "save-all-images-webextension" = buildFirefoxXpiAddon {
      pname = "save-all-images-webextension";
      version = "0.8.0";
      addonId = "{32af1358-428a-446d-873e-5f8eb5f2a72e}";
      url = "https://addons.mozilla.org/firefox/downloads/file/4082376/save_all_images_webextension-0.8.0.xpi";
      sha256 = "92054695474c9e37f156be9d52967e6a8ecc151a5a039afe5b27d8317fd9a389";
      meta = with lib;
      {
        homepage = "https://webextension.org/listing/save-images.html";
        description = "Easily save images with a wide range of customization features, such as file size, dimensions, and image type.";
        license = licenses.mpl20;
        platforms = platforms.all;
        };
      };
    }