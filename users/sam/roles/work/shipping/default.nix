{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ../common/samba.nix
    { drives = [ "Company Shared Data" "QBsCompanyFile" "Shared" ]; }
    ../common
    ./.
  ];
}
