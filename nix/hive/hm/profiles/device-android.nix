{ inputs
, lib, pkgs
, ...
}:
{
  imports = [
    # https://github.com/tadfisher/android-nixpkgs
    #inputs.nixpkgs-android.hmModule
    #{
    #  #inherit config lib pkgs;
    #  android-sdk = {
    #    enable = true;
    #    #path = "${config.xdg.dataHome}/android/sdk";
    #    # nix flake show github:tadfisher/android-nixpkgs
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
    #lib.lists.optional
    #config.gtk.enable
    #../../desktop/gnome/apps/phone.nix
  ];

  home.packages = lib.mkIf (pkgs.system == "x86_64-linux") [
    # --- ADB & Fastboot ---
    #pkgs.android-tools
    inputs.nixpkgs-android.packages.${pkgs.system}.platform-tools
    #inputs.nixpkgs-android.sdk
    #(sdkPkgs: with sdkPkgs; [
    #  build-tools-34-0-0
    #  cmdline-tools-latest
    #  emulator
    #  platform-tools
    #  platforms-android-34
    #])

    pkgs.payload-dumper-go # Android OTA payload dumper
    #pkgs.nur.repos.aleksana.payload-dumper-go # Android OTA payload dumper
    #pkgs.nur.repos.wolfangaukang.device-flasher # Flash CalyxOS to Android device

    #self.packages.fastboot-flash-slot
    #self.packages.fajita-flash-oem
    #self.packages.fajita-flash-all
    #self.packages.fajita-convert-international

    pkgs.rquickshare        # Rust impl of NearbyShare/QuickShare from Android on Linux/MacOS
  ];

}
