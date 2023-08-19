{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    #./lxd.nix
  ];


  # Creates, manages, & mirrors a simplestreams lxd image server on top of nginx.
  services.lxd-image-server = {
    enable = true;
    group = "nginx";  #"www-data";  # Group assigned to the user & the webroot directory

    nginx = {
      enable = false;
      domain = "images.${config.networking.fqdn}";
    };

    # See: https://github.com/Avature/lxd-image-server/blob/master/config.toml
    #settings = {
    #};
  };

}
