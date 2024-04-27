{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    ../common/samba.nix
    { drives = [ "Company Shared Data" "print$" "QBsCompanyFile" "Shared" ]; }
    ../common
    ./.
  ];
}
