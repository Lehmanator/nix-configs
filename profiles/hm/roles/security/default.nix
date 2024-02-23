{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
    ../common
  ];

  home.packages = [
    pkgs.nur.repos.exploitoverload.ADCSKiller
    pkgs.nur.repos.exploitoverload.BloodHound
    pkgs.nur.repos.exploitoverload.bloodhound-python
    pkgs.nur.repos.exploitoverload.Responder
    pkgs.nur.repos.exploitoverload.maltego
    pkgs.nur.repos.exploitoverload.polenum
    pkgs.nur.repos.exploitoverload.psudohash
    pkgs.nur.repos.exploitoverload.seclists

    pkgs.nur.repos.jjjollyjim.exploitdbFull
    pkgs.nur.repos.k3a.steghide


    pkgs.nur.repos.mipmip.cryptobox # Script to create, mount, & unmount LUKS encrypted disk image files
    pkgs.nur.repos.mloeper.git-credential-manager # Git credential storage w/ auth to GH, Azure Repos, ...

  ];

}
