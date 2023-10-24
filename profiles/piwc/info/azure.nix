{ inputs
, config
, lib
, pkgs
, ...
}:
{
  #imports = [
  #  inputs.agenix.nixosModules.agenix
  #  #inputs.sops-nix.nixosModules.sops
  #];

  azure = rec {
    domain = "piwine.com";
    alternateDomains = [ "pi.wine" "piwines.onmicrosoft.com" ];

    # TODO: Make encrypted secret?
    tenantId = "41bc3724-2a8e-4c9f-9cbd-a4ea169ef081";
    #"eae67810-0ea3-449d-9ce1-aebb22f3fccb";

    owner = {
      email = "admin@${domain}";
      licenses = [ "azure-ad-premium-p1" ];
    };

    auth = {
      oauth = {
        baseURL = "https://login.microsoftonline.com/${tenantId}";
        oauthURL = "${auth.oauth.baseURL}/oauth2/v2.0";
        authorizationURLv1 = "${auth.oauth.baseURL}/oauth2/authorize";
        authorizationURL = "${auth.oauth.oauthURL}/authorize";
        tokenURL = "${auth.oauth.oauthURL}/oauth2/v2.0/token";
        openidMetadataURL = "${auth.oauth.baseURL}/v2.0/.well-known/openid-configuration";
        federationMetadataURL = "${auth.oauth.baseURL}/federationmetadata/2007-06/federationmetadata.xml";
        wsfedURL = "${auth.oauth.baseURL}/wsfed";
        samlpSignonURL = "${auth.oauth.baseURL}/saml2";
        samlpSignoutURL = "${auth.oauth.baseURL}/saml2";
      };

      ldap = { };

      kerberos = { };

      saml = { };
    };

  };

}
