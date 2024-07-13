{ config, lib, pkgs, ... }: {
  #imports  = with cell.homeProfiles; [java kotlin];

  # TODO: Convert to //android/devShells/android-app-development
  # https://nixos.org/manual/nixpkgs/unstable/#android
  home = let
    # --- Install Android SDK & Tools ---
    androidComposition = pkgs.androidenv.composeAndroidPackages {
      abiVersions = ["armeabi-v7a" "arm64-v8a"];
      buildToolsVersions = ["34.0.0"];
      cmakeVersions = ["3.10.2"];
      cmdLineToolsVersion = "8.0";
      emulatorVersion = "35.1.4";
      platformVersions = ["30" "31" "32" "33" "34"];
      platformToolsVersion = "34.0.5";
      ndkVersions = ["22.0.7026061"];
      toolsVersion = "26.1.1";
      includeEmulator = true;
      includeExtras = [
        #"extras;google;gcm"
      ];
      includeNDK = true;
      includeSources = true;
      includeSystemImages = true;
      systemImageTypes = [
        #"google_apis_playstore"
      ];
      useGoogleAPIs = false;
      useGoogleTVAddOns = false;
      # Can get these names from `repo.json` OR `querypackages.sh licenses`
      extraLicenses = [
        "android-sdk-license"
        "android-sdk-preview-license"
      ];
      #repoJson = "~/path/repo.json"; # Generated repo.json filepath. Generate w/ generate.sh that calls mkrepo.rb
      #repoXmls = {
      #  packages = [ ./xml/repository2-1.xml ];
      #  images = [
      #    ./xml/android-sys-img2-1.xml
      #    ./xml/android-tv-sys-img2-1.xml
      #    ./xml/android-wear-sys-img2-1.xml
      #    ./xml/android-wear-cn-sys-img2-1.xml
      #    ./xml/google_apis-sys-img2-1.xml
      #    ./xml/google_apis_playstore-sys-img2-1.xml
      #  ];
      #  addons = [ ./xml/addon2-1.xml ];
      #};
    };

    # --- Build Android Apps ---
    androidAppExample = pkgs.androidenv.buildApp {
      name = "MyAndroidApp";
      src = ./myappsources;
      release = true;
      # If release is set to true, you need to specify the following parameters
      keyStore = ./keystore;
      keyAlias = "myfirstapp";
      keyStorePassword = "mykeystore";
      keyAliasPassword = "myfirstapp";
      # Any Android SDK parameters that install all the relevant plugins that a
      # build requires
      platformVersions = ["34"];
      # When we include the NDK, then ndk-build is invoked before Ant gets invoked
      includeNDK = true;
    };

    # --- Spwan Emulator Instances ---
    emuApp = pkgs.androidenv.emulateApp {
      name = "emulate-MyAndroidApp";
      platformVersion = "34";
      abiVersion = "armeabi-v7a"; # mips, x86, x86_64
      systemImageType = "default";
      app = ./MyApp.apk;
      package = "MyApp";
      activity = "MainActivity";
    };
  in {
    packages = [
      androidComposition.androidsdk
    ];
    sessionVariables = {
      ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
      ANDROID_NDK_ROOT = "${config.home.sessionVariables.ANDROID_SDK_ROOT}/ndk-bundle";
      # Use the same buildToolsVersion here
      GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${config.home.sessionVariables.ANDROID_SDK_ROOT}/build-tools/${androidComposition.buildToolsVersion}/aapt2";
    };
  };
}
