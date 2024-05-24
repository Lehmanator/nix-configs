{ inputs, config, lib, pkgs, ... }: {
  imports = [
    # Working with Windows-specific formats on Linux
    inputs.self.devshellProfiles.windows-formats

    # Working with servers for Windows services
    inputs.self.devshellProfiles.windows-servers
  ];

  env = [ ];
  commands = [
    #{ name = "ldd"; help = "Figure out what libraries a binary needs."; command = "${pkgs.nix-ld}/bin/ldd"; }
  ];
  packages = [
    # --- Hardware, Boot, & BIOS ---
    pkgs.surface-control # Control various aspects of Microsoft Surface devices on Linux from the Command-Line
    pkgs.thin-provisioning-tools # A suite of tools for manipulating the metadata of the dm-thin device-mapper target

    # --- Shell ---
    pkgs.powershell # Powerful cross-platform (Windows, Linux, and macOS) shell and scripting language based on .NET
    pkgs.vscode-extensions.ms-vscode.powershell # A Visual Studio Code extension for PowerShell language support

    # --- Productivity ---
    pkgs.nb # A command line note-taking, bookmarking, archiving, and knowledge base application

    # --- Secrets ---
    pkgs.keychain # Keychain management tool
  ] ++ lib.optionals pkgs.stdenv.isLinux [
    # --- Compat Layers ---
    # TODO: WINE & Bottles
    pkgs.msbuild # Mono version of Microsoft Build Engine, the build platform for .NET, and Visual Studio
    pkgs.playonlinux # GUI for managing Windows programs under linux
    pkgs.proton-caller # Run Windows programs with Proton
    pkgs.wibo # Quick-and-dirty wrapper to run 32-bit windows EXEs on linux
  ];
}
