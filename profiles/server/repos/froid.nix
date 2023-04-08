{ self, inputs,
  system ? "x86_64-linux",
  host, network, repo,
  config, lib, pkgs,
  ...
}:
{
  imports = [
    ../nginx.nix
  ];

  # --- WARNING --------------------------------------------
  # YOU SHOULD ALWAYS RUN THIS IN A VIRTUAL MACHINE!
  # An adversary could place arbitrary commands in the custom build steps for
  # any app, so they could execute malicious code on your machine.
  environment.systemPackages = [
    pkgs.fdroidserver               # F-Droid repo server

    pkgs.androidStudioPackages.dev  # Android Studio (dev edition)

    pkgs.android-tools              # Android utils (adb, fastboot, etc)
    pkgs.android-udev-rules         # udev device rules for Android devices
    pkgs.android-backup-extractor   # Extract backups from Android
    pkgs.apkid                      # Android App identifier
    pkgs.apksigner                  # CLI APK signing tool
    pkgs.apksigcopier               # Copy APK signatures to compare apps
    pkgs.apktool                    # Tool to reverse engineer APK files
    pkgs.bionic                     # Android libc implementation
    pkgs.bundletool                 # Tools to work with Android app bundles
    pkgs.dex2jar                    # Dex to Java decompiler
    pkgs.flutter                    # Dart SDK for mobile, web, desktop apps
    pkgs.git-repo                   # Android's repo management tool
    pkgs.jadx                       # Dex to Java decompiler
    pkgs.openjdk16-bootstrap        # OpenJDK pre-built binary
    pkgs.quark-engine               # Android malware analysis system
    pkgs.trueseeing                 # Non-decompiling Android vulnerabilityy scanner
  ];
  environment.sessionVariables = {
    #ANDROID_HOME = "";
  };

  # TODO: Add to groups: `libvirt` & `libvirt-qemu` (& `kvm` ?)
  users.extraUsers = [ "fdroid" ];
  

  # --- Information ----
  # https://monitor.f-droid.org

  # --- Guides ---------
  # https://developer.android.com/studio/publish/app-signing.html#secure-key

  # --- Repos ----------
  # https://gitlab.com/fdroid/fdroiddata             - 
  # https://gitlab.com/fdroid/fdroidserver           - 
  # https://gitlab.com/fdroid/fdroid-bootstrap-buildserver - 
  # https://gitlab.com/fdroid/fdroid-suss            - Suspicious signatures
  # https://gitlab.com/fdroid/sdkmanager             - Python replacement for SDK Manager

  # --- Containers -------
  # https://gitlab.com/fdroid/docker-executable-fdroidserver - Docker container

  # --- CI/CD ------------
  # https://gitlab.com/fdroid/issuebot
  # https://gitlab.com/fdroid/repo-monitor

  # --- Webservers -------
  # https://gitlab.com/fdroid/fdroid-monitor                - WebApp for browsing F-Droid build server infos

  # --- Desktop Tools ----
  # https://gitlab.com/fdroid/repomaker

  # --- Android Device ---
  # https://gitlab.com/fdroid/android_vendor_fdroid  - For building F-Droid into custom ROMs
  # https://gitlab.com/fdroid/fdroidclient           - Android F-Droid app (-nightly)
  # https://gitlab.com/fdroid/privileged-extension   - Android app to get root privileges for installing apps (-nightly)
}
