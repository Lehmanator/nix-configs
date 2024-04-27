{ inputs
, config
, lib
, pkgs
, ...
}:
{
  home.packages = [
    pkgs.ksmbd-tools # Userspace utilities for the ksmbd kernel SMB server
    #pkgs.samba4Full      # Standard Windows interoperability suite of Linux/Unix programs
    #pkgs.enum4linux-ng  # Windows/Samba enumeration tool
    #pkgs.erosmb         # SMB network scanner
    #pkgs.python311Packages.aiosmb  # Python SMB lib
    #pkgs.sambamba       # SAM/BAM processing tool
    #pkgs.smbnetfs       # FUSE FS for mounting Samba shares
    #pkgs.smbmap         # SMB enumeration tool
    #pkgs.smbscan        # Tool to enumerate file shares
    #pkgs.wsdd           # A Web Service Discovery (WSD) host daemon for SMB/Samba
  ];
}
