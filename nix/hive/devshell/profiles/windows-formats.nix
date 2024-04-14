{ inputs, config, lib, pkgs, ... }: {
  imports = [ ];
  env = [ ];
  commands = [
    #{name=""; category="Windows"; help=""; command="";}
  ];
  packages = [
    pkgs.python311Packages.pylnk3 # Python library for reading and writing Windows shortcut files (.lnk)
    pkgs.winhelpcgi # CGI module for Linux, Solaris, MacOS X and AIX to read Windows Help Files

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
  ];
}
