{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: {
  imports = [
    #./certificates.nix
    #./hardening.nix
    #./trusted-sites.nix
  ];

  # Firefox only supports int, bool, and string types for preferences, but home-manager will automatically convert all other JSON-compatible values into strings.
  programs.firefox.profiles.base.settings = let
    site-list = builtins.concatStringsSep ", " (osConfig.networking.domains
      ++ [
        "samlehman.me"
        "samlehman.dev"
        "samlehman.biz"
        "samlehman.cloud"
        "lehman.run"
        "redstone.pw"
      ]);
  in {
    # TODO: Test if attrset nesting works or need to use full option path string
    # Auto GSS-API/SPNEGO auth for trusted sites
    "network.negotiate-auth.trusted-uris" = site-list;
    "network.negotiate-auth.delegation-urls" = site-list;
    "network.automatic-ntlm-auth.trusted-uris" = site-list;
    "network.automatic-ntlm-auth.allow-non-fqdn" = true;
    "network.negotiate-auth.allow-non-fqdn" = true;
  };
}
