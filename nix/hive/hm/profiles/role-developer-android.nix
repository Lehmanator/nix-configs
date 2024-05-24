{
  config,
  lib,
  pkgs,
  ...
}: {
  #imports  = [
  #  ./java.nix
  #  ./kotlin.nix
  #];

  # https://nixos.org/manual/nixpkgs/unstable/#android
  home = let
    # --- Install Android SDK & Tools ---
    androidComposition = pkgs.androidenv.composeAndroidPAckages {
      cmdLineToolsVersion = "8.0";
      toolsVersion = "26.1.1";
      platformToolsVersion = "30.0.5";
      buildToolsVersions = ["30.0.3"];
      includeEmulator = true;
      emulatorVersion = "30.3.4";
      platformVersions = ["28" "29" "30" "31"];
      includeSources = true;
      includeSystemImages = true;
      systemImageTypes = [
        #"google_apis_playstore"
      ];
      abiVersions = ["armeabi-v7a" "arm64-v8a"];
      cmakeVersions = ["3.10.2"];
      includeNDK = true;
      ndkVersions = ["22.0.7026061"];
      useGoogleAPIs = false;
      useGoogleTVAddOns = false;
      includeExtras = [
        #"extras;google;gcm"
      ];
      extraLicenses = [
        # Can get these names from `repo.json` OR `querypackages.sh licenses`
        #"android-sdk-license"
        #"android-sdk-preview-license"
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
      platformVersions = ["24"];
      # When we include the NDK, then ndk-build is invoked before Ant gets invoked
      includeNDK = true;
    };

    # --- Spwan Emulator Instances ---
    emuApp = pkgs.androidenv.emulateApp {
      name = "emulate-MyAndroidApp";
      platformVersion = "24";
      abiVersion = "armeabi-v7a"; # mips, x86, x86_64
      systemImageType = "default";
      app = ./MyApp.apk;
      package = "MyApp";
      activity = "MainActivity";
    };
  in {
    packages = [androidComposition.androidsdk];
    sessionVariables = {
      ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
      ANDROID_NDK_ROOT = "${config.home.sessionVariables.ANDROID_SDK_ROOT}/ndk-bundle";
      # Use the same buildToolsVersion here
      GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${config.home.sessionVariables.ANDROID_SDK_ROOT}/build-tools/${androidComposition.buildToolsVersion}/aapt2";
    };
  };
}
