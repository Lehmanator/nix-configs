{ inputs, lib, ... }:
{
  security.acme = {
    defaults.email = "github@samlehman.dev";
    acceptTerms = true;
  };
  #environment.persistence."/nix/persist".directories = ["/var/lib/acme"];
}
