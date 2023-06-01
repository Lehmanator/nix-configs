{
  allowAliases                    =  true;
  allowBroken                     =  true;
  allowInsecure                   =  false;
  allowUnfree                     =  true;
  allowUnsupportedSystem          =  false;
  checkMeta                       =  true;   # Whether to check derivations' `meta` attr during eval time
  #configurePlatformsByDefault     =  true;   # Warn: May cause mass rebuild upon change
  #contentAddressedByDefault       =  true;   # Warn: May cause mass rebuild upon change
  #doCheckByDefault                =  true;   # Warn: May cause mass rebuild upon change
  #enableParallelBuildingByDefault =  true;   # Warn: May cause mass rebuild upon change
  #strictDepsByDefault             =  false;  # Warn: May cause mass rebuild upon change
  #structuredAttrsByDefault        =  false;  # Warn: May cause mass rebuild upon change
  warnUndeclaredOptions           =  true;

  #allowInsecurePredicate = pkg: builtins.elem (lib.getName pkg) [
  #];
  #allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #  "vscode"
  #];
  #allowlistedLicenses = with lib.licenses; [ amd wtfpl ];
  #blocklistedLicenses = with lib.licenses; [ agpl3Only gpl3Only ];
  #permittedInsecurePackages = [
  #];
  #packageOverrides = pkgs: rec {
  #  foo = pkgs.foo.override {  };
  #};
  #showDerivationWarnings = [
  #];
}
