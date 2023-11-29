{ inputs
, config
, lib
, pkgs
, host
, ...
}:
{
  # TODO: Build https://github.com/Bitsteward/bitsteward


  imports = [
  ];

  home.packages = [
    pkgs.bitwarden
    pkgs.nur.repos.ambroisie.bw-pass
  ];

  #programs.rbw.enable = true;
  #programs.rbw.settings = {
  #lock_timeout = 3600;
  #email = "slehman@piwine.com";  # TODO: Use secret
  #base_url = "bitwarden.";       # TODO: Use secret
  #identity_url = "identity.";    # TODO: Use secret
  #};

}
