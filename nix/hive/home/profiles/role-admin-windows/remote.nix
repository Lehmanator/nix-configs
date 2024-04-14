{ inputs, config, lib, pkgs, ... }: {
  home.packages = [
    # --- Libraries ---
    pkgs.python311Packages.dsinternals # Python library for Windows Remote Management

    # --- Remote Desktop ---
    pkgs.freerdp # A Remote Desktop Protocol Client
    pkgs.gtk-frdp # RDP viewer widget for GTK
    pkgs.gnome.vinagre # Remote desktop viewer for GNOME
    pkgs.gnome-connections # A remote desktop client for the GNOME desktop environment
    pkgs.gnomeExtensions.remmina-search-provider # Search for Remmina Remote Desktop Connections
    pkgs.guacamole-server # Clientless remote desktop gateway
    pkgs.guacamole-client # Clientless remote desktop gateway
    pkgs.remote-touchpad # Control mouse and keyboard from the webbrowser of a smartphone.
    pkgs.remotebox # VirtualBox client with remote management
    pkgs.remmina # Remote desktop client written in GTK
    pkgs.realvnc-vnc-viewer # VNC remote desktop client software by RealVNC

    # --- Remote Commands ---
    pkgs.pdsh # High-performance, parallel remote shell utility
    pkgs.rdesktop # Open source client for Windows Terminal Services
    pkgs.remote-exec # Work with remote hosts seamlessly via rsync and ssh
    pkgs.sshfs # FUSE-based filesystem that allows remote filesystems to be mounted over SSH
    pkgs.tty-share # Share terminal via browser for remote work or shared sessions
    pkgs.python311Packages.pypsrp # PowerShell Remoting Protocol Client library
    pkgs.openwsman # Openwsman server implementation and client API with bindings
    pkgs.wsmancli # Openwsman command-line client

    # --- Remote Support ---
    pkgs.anydesk # Desktop sharing application, providing remote support and online meetings
    pkgs.dayon # An easy to use, cross-platform remote desktop assistance solution
    pkgs.rustdesk # Virtual / remote desktop infrastructure for everyone! Open source TeamViewer / Citrix alternative
    pkgs.teamviewer # Desktop sharing application, providing remote support and online meetings

    # --- Cluster ---
    pkgs.telepresence # Local development against a remote Kubernetes or OpenShift cluster

    # --- Dev ---
    pkgs.git-annex-remote-rclone # Use rclone supported cloud storage providers with git-annex

    # --- Remote ---
    pkgs.davfs2 # Mount WebDAV shares like a typical filesystem
    pkgs.rsnapshot # A filesystem snapshot utility for making backups of local and remote systems
    pkgs.selenium-server-standalone # Selenium Server for remote WebDriver
    pkgs.shellhub-agent # Enables easy access any Linux device behind firewall and NAT
    pkgs.ultrablue-server # User-friendly Lightweight TPM Remote Attestation over Bluetooth
  ] ++ lib.optionals pkgs.stdenv.isLinux [ ]
  ++ lib.optionals config.gtk.enable [
    # --- GNOME Extensions ---
    pkgs.gnomeExtensions.allow-locked-remote-desktop # Allow remote desktop connections when the screen is locked
    pkgs.gnomeExtensions.autokey-extension # Adds dbus calls which can return list of windows, move, resize, close them for use with Autokey scripting. This extension is a fork of ickyicky's window-calls found at https://github.com/ickyicky/window-calls
    pkgs.gnomeExtensions.rclone-manager # Is like Dropbox sync client but for more than 30 services, adds an indicator to the top panel so you can manage the rclone profiles configured in your system, perform operations such as mount as remote, watch for file modifications, sync with remote storage, navigate it's main folder. Also, it shows the status of each profile so you can supervise the operations, and provides an easy access log of events. Backup and restore the rclone configuration file, so you won't have to configure all your devices one by one
  ];
}
