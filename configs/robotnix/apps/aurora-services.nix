{ self, inputs, config, lib, pkgs,
  host, network, repo,
  ...
}:
{
  apps.prebuilt.AuroraServices  = {
    apk = (pkgs.fetchurl {
      url = "https://gitlab.com/AuroraOSS/AuroraServices/uploads/c22e95975571e9db143567690777a56e/AuroraServices_v1.1.1.apk";
      sha256 = "sha256-8D83aPGVWQfsMTrkl8/ZK09vWO4cAbazi9C2oqmlBZM=";
    });
    privileged = true;
    privappPermissions = [ "INSTALL_PACKAGES" "DELETE_PACKAGES" ];
    packageName = "com.aurora.services";
  };
}
