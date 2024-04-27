{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    # TODO: Build package: https://github.com/Bitsteward/bitsteward
    #./bitsteward.nix
    #./cli.nix
    #./pass.nix
    #./rbw.nix
  ];

  home.packages = [
    pkgs.bitwarden
    pkgs.nur.repos.ambroisie.bw-pass
  ];

  #programs.rbw = {
  #  enable = true;
  #  settings = {
  #    lock_timeout = 3600;
  #    # TODO: Use secret
  #    email = config.sops.secrts.email.text; #"slehman@piwine.com";
  #    base_url = "bitwarden.${config.networking.fqdn}";
  #    identity_url = "identity.${config.networking.fqdn}";
  #  };
  #};
  #sops.secrets.email = { }; # TODO: Read secret as text, not file.

}
