{ inputs, config, lib, pkgs, user, ... }: {
  # Enable automatic login for user
  services.xserver.displayManager.autoLogin = {
    inherit user;
    enable = true;
  };
  # --- KDE-Specific ---
  # --- GNOME-Specific ---
  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services =
    lib.mkIf config.services.xserver.desktopManager.gnome.enable {
      "autovt@tty1".enable = false;
      "getty@tty1".enable = false;
    };
}
