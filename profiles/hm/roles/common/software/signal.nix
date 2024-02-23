{ inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.nur.repos.dschrempf.signal-back  # Decrypt Signal IM backups
    pkgs.nur.repos.mic92.signald          # Daemon for programs to interface with Signal IM
    pkgs.signal-desktop                   # Signal IM Electron client
  ];

}
