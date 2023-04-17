{
  self,
  system,
  inputs,
  config, lib, pkgs,

  host, network,
  ...
}:
let
in
{
  imports = [
    ./postgresql.nix
    ../server/quickbooks.nix
    #../server/postgresql.nix
  ];


  services.postgresql.ensureDatabases = [
    "quickbooks"
  ];
  services.postgresql.ensureUsers = [
    { name = "quickbooks";
      ensurePermissions = [

      ];
    }
  ];
}
