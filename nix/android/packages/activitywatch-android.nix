{
  androidenv,
  activitywatch,
  aw-server-rust,
  lib,
  stdenv,
  fetchFromGitHub,
}:
androidenv.buildApp rec {
  name = "activitywatch-android";
  pname = "activitywatch-android";
  version = "0.12.1";

  #release = true;
  #keyStore = ./keystore;
  #keyAlias = "activitywatch";
  #keyStorePassword = "mykeystore";
  #keyAliasPassword = "myactivitywatchapp";
  platformVersions = ["34"];
  includeNDK = true;
  #android_sdk.accept_license = true;

  src = fetchFromGitHub {
    owner = "ActivityWatch";
    repo = "aw-android";
    rev = "v${version}";
    hash = "sha256-ED15iCC5cSOA+Oh4eEcIb6JPzDbd55P9grPs3IXB0vE=";
    fetchSubmodules = true;
  };

  meta = with lib; {
    description = "ActivityWatch for Android, using aw-server-rust as backend";
    homepage = "https://github.com/ActivityWatch/aw-android";
    license = licenses.mpl20;
    maintainers = with maintainers; [];
    mainProgram = "aw-android";
    platforms = platforms.all;
  };
}
