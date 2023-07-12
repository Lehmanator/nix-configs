{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ../common/samba.nix { drives = [ "ADMIN$" "C$" "Company Shared Data" "D$" "E$" "NETLOGON" "PIWINE-SVR03" "print$" "QBsCompanyFile" "Shared" "Staff_Data" "SystemState$" "SYSVOL" ]; }
    ../common
    ../../sysadmin/azure.nix
    ../../sysadmin/kubernetes.nix
    ./.
  ];
}