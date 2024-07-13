{ config, lib, pkgs , ... }: {
  home.packages = [
    pkgs.onedrive
    pkgs.onedriver
    pkgs.onedrivegui
    # pkgs.nur.repos.splintah.onedrive
    pkgs.nur.repos.thaumy.microsoft-todo-electron
    #pkgs.evolution-ews
  ] ++ lib.optionals config.programs.gnome-shell.enable [
    # pkgs.gnomeExtensions.onedrive
    pkgs.gnomeExtensions.one-drive-resurrect
  ];

}
