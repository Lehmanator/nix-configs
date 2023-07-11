{ inputs, self
, config, lib, pkgs
, ...
}:
{
  imports = [
    ../common/samba-drives.nix { drives = [ "ADMIN$" "C$" "Company Shared Data" "D$" "E$" "NETLOGON" "PIWINE-SVR03" "print$" "QBsCompanyFile" "Shared" "Staff_Data" "SystemState$" "SYSVOL" ]; }
  ];

  home.packages = [
    pkgs.ksmbd-tools
    pkgs.samba4Full
  ];

}
