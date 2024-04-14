{ inputs, config, lib, pkgs, ... }: {
  # TODO: Create devshellProfiles.windows-{compat,formats,remote,servers,virt}
  # TODO: Create shells.windows
  imports = [
    # Compatibility for Windows stuff
    ./compat.nix

    # Remotely accessing/managing/configuring Windows systems
    ./remote.nix

    # Virtualizing/Emulating Windows Environments/Software
    ./virt.nix
  ];

  # TODO: Split into directory?
  home.packages = [
    # --- Hardware, Boot, & BIOS ---
    pkgs.thin-provisioning-tools # A suite of tools for manipulating the metadata of the dm-thin device-mapper target

    # --- Shell ---
    pkgs.powershell # Powerful cross-platform (Windows, Linux, and macOS) shell and scripting language based on .NET
    pkgs.vscode-extensions.ms-vscode.powershell # A Visual Studio Code extension for PowerShell language support

    # --- Dev ---
    pkgs.git-annex-remote-rclone # Use rclone supported cloud storage providers with git-annex

    # --- Hardware ---
    pkgs.surface-control # Control various aspects of Microsoft Surface devices on Linux from the Command-Line
  ] ++ lib.optionals pkgs.stdenv.isLinux [ ]
  ++ lib.optionals config.gtk.enable [
    # --- GNOME Extensions ---
    pkgs.gnomeExtensions.autokey-extension # Adds dbus calls which can return list of windows, move, resize, close them for use with Autokey scripting. This extension is a fork of ickyicky's window-calls found at https://github.com/ickyicky/window-calls
    pkgs.gnomeExtensions.mouse-follows-focus # Are you a power-user?
    pkgs.gnomeExtensions.rclone-manager # Is like Dropbox sync client but for more than 30 services, adds an indicator to the top panel so you can manage the rclone profiles configured in your system, perform operations such as mount as remote, watch for file modifications, sync with remote storage, navigate it's main folder. Also, it shows the status of each profile so you can supervise the operations, and provides an easy access log of events. Backup and restore the rclone configuration file, so you won't have to configure all your devices one by one
  ];
}
