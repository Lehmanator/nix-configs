{
  config,
  lib,
  pkgs,
  ...
}: {
  security.acme = {
    acceptTerms = true;
    defaults = {
      email = "acme@samlehman.dev";
    };
  };
}
