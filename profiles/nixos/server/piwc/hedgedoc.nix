{ inputs
, config
, lib
, pkgs
, secretsDir ? "/run/secrets"
, ...
}:
{
  services.hedgedoc = {
    settings = {
      azure = {
        connectionString = "";
        container = "";
      };
    };
  };

  #CMD_OAUTH2_USER_PROFILE_URL=https://your.azureprofileurl.com/auth/oauth2/callback
  #CMD_OAUTH2_USER_PROFILE_USERNAME_ATTR=yourPrincipalName
  #CMD_OAUTH2_USER_PROFILE_DISPLAY_NAME_ATTR=displayName
  #CMD_OAUTH2_USER_PROFILE_EMAIL_ATTR=email
  #CMD_OAUTH2_USER_PROFILE_ID_ATTR=id
  #CMD_OAUTH2_TOKEN_URL=https://login.microsoftonline.com/**DIRECTORY-ID**/oauth2/v2.0/token
  #CMD_OAUTH2_AUTHORIZATION_URL=https://login.microsoftonline.com/**DIRECTORY-ID**/oauth2/v2.0/authorize
  #CMD_OAUTH2_CLIENT_ID=APPLICATION-ID
  #CMD_OAUTH2_CLIENT_SECRET=CLIENT-SECRET
  #CMD_OAUTH2_PROVIDERNAME=AzureAD
  #CMD_OAUTH2_SCOPE=openid_offline_access
}
