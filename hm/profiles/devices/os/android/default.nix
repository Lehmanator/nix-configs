{ inputs, lib, pkgs, ... }:
{
  # https://github.com/tadfisher/android-nixpkgs
  imports = [
    #inputs.nixpkgs-android.hmModule
    #{ inherit config lib pkgs;
    #  android-sdk = {
    #    enable = true;
    #    path = "${config.xdg.dataHome}/android/sdk";
    #    packages = sdk: with sdk; [
    #      build-tools-34-0-0
    #      cmdline-tools-latest
    #      emulator
    #      platform-tools
    #      platforms-android-34
    #      sources-android-34
    #    ];
    #  };
    #}
  ] #++ (lib.lists.optional config.gtk.enable (inputs.self + /hm/profiles/gnome/apps/phone.nix))
  ;
  home.packages = lib.mkIf (pkgs.system=="x86_64-linux") [
    pkgs.adbtuifm           # ADB TUI
    pkgs.android-tools      # Android tools like ADB & fastboot
    pkgs.git-repo           # Android git repo management util
    pkgs.payload-dumper-go  # Android OTA payload dumper
    pkgs.rquickshare        # Rust impl of NearbyShare/QuickShare from Android on Linux/MacOS

    #pkgs.nur.repos.wolfangaukang.device-flasher    # Flash CalyxOS to Android device
    #inputs.nixpkgs-android.packages.${pkgs.system}.platform-tools
    #inputs.nixpkgs-android.sdk (sdkPkgs: with sdkPkgs; [
    #  build-tools-34-0-0
    #  cmdline-tools-latest
    #  emulator
    #  platform-tools
    #  platforms-android-34
    #])
  ] #++ (with self.packages.${pkgs.system}; [fastboot-flash-slot fajita-flash-oem fajita-flash-all fajita-convert-international])
  ;
}
