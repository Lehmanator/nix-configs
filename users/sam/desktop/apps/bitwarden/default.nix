{
  config, lib, pkgs,
  host,
  ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.bitwarden
  ];

  #programs.rbw.enable = true;
  #programs.rbw.settings = {
    #lock_timeout = 3600;
    #email = "slehman@piwine.com";  # TODO: Use secret
    #base_url = "bitwarden.";       # TODO: Use secret
    #identity_url = "identity.";    # TODO: Use secret
  #};

}
