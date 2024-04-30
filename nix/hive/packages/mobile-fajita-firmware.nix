{
  lib,
  fetchFromGitLab,
  runCommand,
}: let
  baseFw = fetchFromGitLab {
    owner = "sdm845-mainline";
    repo = "firmware-oneplus-sdm845";
    #rev = "3ec855b2247291c79652b319dfe93f7747363c86";
    #sha256 = "sha256-7CaXWOpao+vuFA7xknzbLml2hxTlmuzFCEM99aLD2uk=";
    hash = "sha256-bad9CqgRoXx8AyVrGycKQRRcPpPnQy2TsZRBw6u1eIY=";
    rev = "9dd812bbdf0ccad819c273fea9466152cbf3e71b";
  };
in
  runCommand "oneplus-sdm845-firmware" {
    inherit baseFw;
    # We make no claims that it can be redistributed.
    meta.license = lib.licenses.unfree;
  } ''
    mkdir -p $out/lib/firmware
    cp -r $baseFw/lib/firmware/* $out/lib/firmware/
    chmod +w -R $out
    rm -rf $out/lib/firmware/postmarketos
    cp -r $baseFw/lib/firmware/postmarketos/* $out/lib/firmware
  ''
