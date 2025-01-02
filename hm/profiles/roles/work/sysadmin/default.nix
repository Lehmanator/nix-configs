{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    (inputs.self + /hm/profiles/roles/sysadmin/azure.nix)
    (inputs.self + /hm/profiles/roles/sysadmin/kubernetes)
    (inputs.self + /hm/profiles/xdg.nix)

    (inputs.self + /hm/profiles/roles/work/common)
    (inputs.self + /hm/profiles/roles/work/common/samba.nix)
    (inputs.self + /hm/profiles/roles/work/sysadmin/bitwarden.nix)
    (inputs.self + /hm/profiles/roles/work/sysadmin/git.nix)
    # { drives = [ "ADMIN$" "C$" "Company Shared Data" "D$" "E$" "NETLOGON" "PIWINE-SVR03" "print$" "QBsCompanyFile" "Shared" "Staff_Data" "SystemState$" "SYSVOL" ]; }
  ];
}
