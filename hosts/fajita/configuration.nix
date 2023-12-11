#
# This file represents safe opinionated defaults for a basic GNOME mobile system.
#
# NOTE: this file and any it imports **have** to be safe to import from
#       an end-user's config.
#
{ inputs
, config
, lib
, pkgs
, user
, ...
}:
let
  #kernelConfig = (import inputs.mobile-nixos + "devices/families/sdm845-mainline/kernel/config.aarch64") + ''
  #'';
  kversion = "6.6.3";
  krev = "sdm845-${kversion}";
in
{
  users.users.${user} = {
    isNormalUser = true;
    uid = 1000;
    password = lib.mkForce "545352";
    extraGroups = [ "dialout" "feedbackd" "networkmanager" "video" "wheel" "gdm" ];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB2M80EUw0wQaBNutE06VNgSViVot6RL0O6iv2P1ewWH ${user}@fw" ];
  };
  services.openssh.enable = true;
  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    sensor.iio.enable = true;
  };
  services.pipewire.enable = lib.mkForce false;
  zramSwap.enable = true;
  networking.firewall.enable = false;
  system.stateVersion = "23.11";

  #mobile.device.firmware = pkgs.fajita-firmware;
  #environment.systemPackages = [ pkgs.fajita-kernel ];
}

# Fix OnePlus 6T kernel
# https://github.com/NixOS/mobile-nixos/commit/88ba967a98b6a7f84349fb16af039cd093a209b0
# https://github.com/NixOS/mobile-nixos/blob/development/devices/oneplus-enchilada/firmware/default.nix
# https://wiki.lineageos.org/devices/enchilada/install#ensuring-all-firmware-partitions-are-consistent
# https://github.com/NixOS/mobile-nixos/blob/development/devices/families/sdm845-mainline/kernel/default.nix
# https://github.com/NixOS/mobile-nixos/blob/development/devices/families/sdm845-mainline/kernel/config.aarch64
# TODO: Set using: mobile.kernel.structuredConfig
#mobile.kernel.structuredConfig = [ ];

# TODO: Add here
# https://github.com/NixOS/mobile-nixos/commit/840f67e94b1c4586aed3000a26b4ba689dbf504d#diff-523a60f3868450fab2d4c04ae4dffadc7090564fc6af206f6db7eac8c6bdc460

#nixpkgs.overlays = [
#  (self: super: {
#    # Alsa firmware - Latest: 12/10/23
#    sdm845-alsa-ucm = self.callPackage ({runCommand, fetchFromGitLab}: runCommand "sdm845-alsa-ucm" {
#      src = fetchFromGitLab {
#        name = "sdm845-alsa-ucm";
#        owner = "sdm845-mainline";
#        repo = "alsa-ucm-conf";
#        rev = "9ed12836b269764c4a853411d38ccb6abb70b383"; # master
#        sha256 = "sha256-QvGZGLEmqE+sZpd15fHb+9+MmoD5zoGT+pYqyWZLdkM=";
#      };
#    } ''
#      mkdir -p $out/share/
#      ln -s $src $out/share/alsa
#    '') { };
#
#    # fajita firmware - Latest: 12/10/23
#    fajita-firmware = self.callPackage ({lib, fetchFromGitLab, runCommand}: runCommand "oneplus-sdm845-firmware" {
#      meta.license = lib.licenses.unfree;
#      baseFw = fetchFromGitLab {
#        owner = "sdm845-mainline";
#        repo = "firmware-oneplus-sdm845";
#        rev = "dc9c77f220d104d7224c03fcbfc419a03a58765e";
#        sha256 = "sha256-jrbWIS4T9HgBPYOV2MqPiRQCxGMDEfQidKw9Jn5pgBI=";
#      };
#    } ''
#      mkdir -p $out/lib/firmware
#      cp -r $baseFw/lib/firmware/* $out/lib/firmware/
#      chmod +w -R $out
#      rm -rf $out/lib/firmware/postmarketos
#      cp -r $baseFw/lib/firmware/postmarketos/* $out/lib/firmware
#    '') { };
#
#    # https://github.com/NixOS/mobile-nixos/blob/development/devices/families/sdm845-mainline/kernel/default.nix
#    # devices/families/sdm845-mainline/kernel/default.nix
#    fajita-kernel = self.callPackage ({mobile-nixos, fetchFromGitLab, fetchpatch, ...}: mobile-nixos.kernel-builder {
#      version = kversion;
#      configFile = ./config.aarch64;
#      src = fetchFromGitLab {
#        owner = "sdm845-mainline";
#        repo = "linux";
#        rev = krev;
#        hash = "";
#        #rev = "sdm845-6.4-r1";
#        #hash = "sha256-XUYv8tOk0vsG11w8UtBKizlBZ03cbQ2QRGyZEK0ECGU=";
#      };
#      patches = [ (fetchpatch { # ASoC: codecs: tas2559: Fix build
#        url = "https://github.com/samueldr/linux/commit/d1b59edd94153ac153043fb038ccc4e6c1384009.patch";
#        sha256 = "sha256-zu1m+WNHPoXv3VnbW16R9SwKQzMYnwYEUdp35kUSKoE=";
#      })];
#      isModular = false;
#      isCompressed = "gz";
#    }) { };
#  })
#];







#boot.kernelPatches = [
#  {
#    name = "fix-oneplus-fajita-screen";
#    patch = null;
#    extraConfig = ''
#      CONFIG_DRM_PANEL_SAMSUNG_S6E3FC2X01 y
#    '';
#  }
#  {
#    name = "fix-oneplus-fajita-screen";
#    patch = null;
#    extraConfig = ''
#      #CONFIG_FB_SIMPLE n
#    '';
#  }
#  {
#    name = "fix-oneplus-fajita-6-2";
#    patch = null;
#    extraConfig = ''
#      CONFIG_NFT_OBJREF n
#      CONFIG_TOUCHSCREEN_FOCALTECH_FTS y
#      CONFIG_TOUCHSCREEN_NT36XXX y
#      CONFIG_INPUT_QCOM_SPMI_HAPTICS y
#      CONFIG_BATTERY_QCOM_FG y
#      CONFIG_CHARGER_QCOM_SMB2 y
#      CONFIG_DRM_PANEL_SAMSUNG_S6E3FC2X01 y
#      CONFIG_SND_SOC_QDSP6_Q6VOICE_DAI y
#      CONFIG_SND_SOC_QDSP6_Q6VOICE y
#      CONFIG_SND_SOC_TFA98XX y
#      CONFIG_SND_SOC_TAS2559 y
#    '';
#  }
#];


