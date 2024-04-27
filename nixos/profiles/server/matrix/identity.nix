{ self, inputs, config, lib, pkgs,
  host, repo, user, network, machine,
  ...
}:
{
  imports = [];

  services.mxisd = {
    enable = true;
    matrix.domain = "redstone.pw";
    # Public hostname of mxisd/ma1sd if different from Matrix domain
    #server.name = null;
    dataDir = "/var/lib/matrix/identity";
    #environmentFile = "";
    extraConfig = {};
  };
}
