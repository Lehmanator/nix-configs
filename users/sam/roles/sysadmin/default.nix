{ self
, inputs
, config, lib, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [

    # --- Samba ---
    pkgs.ksmbd-tools
    pkgs.samba4Full

    # --- Generic Networking ---
    pkgs.nmap
    pkgs.dig

  ];
}
