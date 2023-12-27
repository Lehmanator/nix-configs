{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [ ];

  # TODO: Split into directory?
  home.packages = [

    # --- Azure ---

    # --- Active Directory ---
    pkgs.adreaper # Enumeration tool for Windows Active Directories
    pkgs.enum4linux # A tool for enumerating information from Windows and Samba systems
    pkgs.ldapnomnom # Tool to anonymously bruteforce usernames from Domain controllers
    pkgs.ldapdomaindump # Active Directory information dumper via LDAP
    pkgs.python311Packages.ldapdomaindump # Active Directory information dumper via LDAP
    pkgs.nxdomain # A domain (ad) block list creator

    # --- Compat Layers ---
    # TODO: WINE & Bottles
    pkgs.msbuild # Mono version of Microsoft Build Engine, the build platform for .NET, and Visual Studio
    pkgs.playonlinux # GUI for managing Windows programs under linux
    pkgs.proton-caller # Run Windows programs with Proton
    pkgs.wibo # Quick-and-dirty wrapper to run 32-bit windows EXEs on linux

    # --- Hardware, Boot, & BIOS ---
    pkgs.thin-provisioning-tools # A suite of tools for manipulating the metadata of the dm-thin device-mapper target

    # --- Libraries ---
    # TODO: All Python Azure libs
    pkgs.python311Packages.pylnk3 # Python library for reading and writing Windows shortcut files (.lnk)
    pkgs.python311Packages.pywinrm # Python module to interact with Windows Active Directory
    pkgs.python311Packages.dsinternals # Python library for Windows Remote Management

    # --- Virtual Machines ---
    pkgs.quickemu # Quickly create and run optimised Windows, macOS and Linux desktop virtual machines
    pkgs.gnome.gnome-boxes # Simple GNOME 3 application to access remote or virtual systems

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

    # --- Server Components ---
    pkgs.davmail # A Java application which presents a Microsoft Exchange server as local CALDAV, IMAP and SMTP servers
    pkgs.pykms # Windows KMS (Key Management Service) server written in Python
    pkgs.winhelpcgi # CGI module for Linux, Solaris, MacOS X and AIX to read Windows Help Files

    # --- Shell ---
    pkgs.powershell # Powerful cross-platform (Windows, Linux, and macOS) shell and scripting language based on .NET
    pkgs.vscode-extensions.ms-vscode.powershell # A Visual Studio Code extension for PowerShell language support

    # --- Utils ---
    pkgs.libirecovery # Library and utility to talk to iBoot/iBSS via USB on Mac OS X, Windows, and Linux
    pkgs.sqlcmd # A command line tool for working with Microsoft SQL Server, Azure SQL Database, and Azure Synapse

    # --- Windows Formats ---
    pkgs.cabextract # Free Software for extracting Microsoft cabinet files
    pkgs.chmlib # A library for dealing with Microsoft ITSS/CHM format files
    pkgs.convertlit # A tool for converting Microsoft Reader ebooks to more open formats
    pkgs.evtx # Parser for the Windows XML Event Log (EVTX) format
    pkgs.freetds # Libraries to natively talk to Microsoft SQL Server and Sybase databases
    pkgs.icoutils # Set of programs to deal with Microsoft Windows(R) icon and cursor files
    pkgs.libvisio2svg # Library and tools to convert Microsoft Visio documents (VSS and VSD) to SVG
    pkgs.ms-sys # A program for writing Microsoft-compatible boot records
    pkgs.mslink # Create Windows shortcut files (`.lnk`) from Linux
    pkgs.msitools # Set of programs to inspect and build Windows Installer (.MSI) files
    pkgs.pe-parse # A principled, lightweight parser for Windows portable executable files
    pkgs.pngtoico # Small utility to convert a set of PNG images to Microsoft ICO format
    pkgs.tnef # Unpacks MIME attachments of type application/ms-tnef
    pkgs.woeusb # Create bootable USB disks from Windows ISO images
    pkgs.wv # Converter from Microsoft Word formats to human-editable ones


    # --- Relocate --------------------------------------------------------------
    # TODO: Place in appropriate Nix config files

    # --- GNOME Extensions ---
    pkgs.gnomeExtensions.allow-locked-remote-desktop # Allow remote desktop connections when the screen is locked
    pkgs.gnomeExtensions.autokey-extension # Adds dbus calls which can return list of windows, move, resize, close them for use with Autokey scripting. This extension is a fork of ickyicky's window-calls found at https://github.com/ickyicky/window-calls
    pkgs.gnomeExtensions.gtk4-desktop-icons-ng-ding # Libadwaita/Gtk4 Port of Desktop Icons NG with updated and modified code base, uses gio menus, all functions are async where possible, multiple fixes and new features-
    pkgs.gnomeExtensions.mouse-follows-focus # Are you a power-user?
    pkgs.gnomeExtensions.rclone-manager # Is like Dropbox sync client but for more than 30 services, adds an indicator to the top panel so you can manage the rclone profiles configured in your system, perform operations such as mount as remote, watch for file modifications, sync with remote storage, navigate it's main folder. Also, it shows the status of each profile so you can supervise the operations, and provides an easy access log of events. Backup and restore the rclone configuration file, so you won't have to configure all your devices one by one

    # --- Benchmarking ---
    pkgs.bandwidth # Artificial benchmark for identifying weaknesses in the memory subsystem
    pkgs.bench # Command-line benchmark tool
    pkgs.bonnie # Hard drive and file system benchmark suite
    pkgs.cargo-benchcmp # A small utility to compare Rust micro-benchmarks
    pkgs.cargo-criterion # Cargo extension for running Criterion.rs benchmarks
    pkgs.critcmp # A command line tool for comparing benchmarks run by Criterion
    pkgs.dbench # Filesystem benchmark tool based on load patterns
    pkgs.fbmark # Linux Framebuffer Benchmark
    pkgs.filebench # File system and storage benchmark that can generate both micro and macro workloads
    pkgs.fio # Flexible IO Tester - an IO benchmark tool
    pkgs.fsmark # Synchronous write workload file system benchmark
    pkgs.geekbench # Cross-platform benchmark
    pkgs.glmark2 # OpenGL (ES) 2.0 benchmark
    pkgs.hp2p # A MPI based benchmark for network diagnostics
    pkgs.hyperfine # Command-line benchmarking tool
    pkgs.iozone # IOzone Filesystem Benchmark
    pkgs.lzbench # In-memory benchmark of open-source LZ77/LZSS/LZMA compressors
    pkgs.nbench # A synthetic computing benchmark program
    pkgs.netperf # Benchmark to measure the performance of many different types of networking
    pkgs.ntttcp # A Linux network throughput multiple-thread benchmark tool
    pkgs.rewrk # A more modern http framework benchmarker supporting HTTP/1 and HTTP/2 benchmarks
    pkgs.sockperf # Network Benchmarking Utility
    pkgs.stress-ng # Stress test a computer system
    pkgs.sysbench # Modular, cross-platform and multi-threaded benchmark tool
    pkgs.tsung # A high-performance benchmark framework for various protocols including HTTP, XMPP, LDAP, etc
    pkgs.ttfb # CLI-Tool to measure the TTFB (time to first byte) of HTTP(S) requests

    # --- Cluster ---
    pkgs.kubeclarity # Kubernetes runtime scanner
    pkgs.skaffold # Easy and Repeatable Kubernetes Development
    pkgs.telepresence # Local development against a remote Kubernetes or OpenShift cluster

    # --- Dev ---
    pkgs.git-annex-remote-rclone # Use rclone supported cloud storage providers with git-annex

    # --- Hardware ---
    pkgs.surface-control # Control various aspects of Microsoft Surface devices on Linux from the Command-Line

    # --- Intrusion & Pen-testing ---
    pkgs.dsniff # collection of tools for network auditing and penetration testing
    pkgs.findomain # The fastest and cross-platform subdomain enumerator
    pkgs.kerbrute # Kerberos bruteforce utility
    pkgs.spoofer-gui # Assess and report on deployment of source address validation
    pkgs.python311Packages.masky # Library to remotely dump domain credentials
    pkgs.terrascan # Detect compliance and security violations across Infrastructure

    # --- Productivity ---
    pkgs.nb # A command line note-taking, bookmarking, archiving, and knowledge base application

    # --- Remote ---
    pkgs.davfs2 # Mount WebDAV shares like a typical filesystem
    pkgs.rsnapshot # A filesystem snapshot utility for making backups of local and remote systems
    pkgs.selenium-server-standalone # Selenium Server for remote WebDriver
    pkgs.shellhub-agent # Enables easy access any Linux device behind firewall and NAT
    pkgs.ultrablue-server # User-friendly Lightweight TPM Remote Attestation over Bluetooth

    # --- Secrets ---
    pkgs.keychain # Keychain management tool

    # --- Servers ---
    pkgs.darkstat # Network statistics web interface
    pkgs.dico # Flexible dictionary server and client implementing RFC 2229
    pkgs.powerdns-admin # A PowerDNS web interface with advanced features
    pkgs.radicale2 # CalDAV CardDAV server

  ];

}
