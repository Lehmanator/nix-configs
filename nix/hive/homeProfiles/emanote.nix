{
  inputs,
  self,
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [inputs.emanote.homeManagerModule.default];
  services.emanote = {
    enable = true;
    host = "127.0.0.1";
    port = 7000;
    baseUrl = "/";

    # TODO: Project `./docs` dirs?
    notes = [
      "${config.home.homeDirectory}/Notes"
      "${config.home.homeDirectory}/Documents/Blog"
      "${config.home.homeDirectory}/Documents/Notes"
      "${config.home.homeDirectory}/Documents/Resume"
      "${config.home.homeDirectory}/Projects/Blog"
      "${self}/docs"
    ];

    # See https://emanote.srid.ca/demo/yaml-config for
    # information about the format.
    extraConfig = {template = {urlStrategy = "pretty";};};
  };

  osConfig.services.nginx.virtualHosts = {
    "blog.lehman.run" = {
      forceSSL = true;
      enableACME = true;
      locations = {
        "/" = {
          proxyPass = "http://localhost:${config.services.emanote.port}";
        };
      };
    };
  };
}
