{ self, inputs
, config, lib, pkgs
, user ? "sam"
, ...
}:
{
  imports = [
  ];

  # --- Generic ---
  # Enable automatic login for user
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = user;

  # --- GNOME-Specific ---
  # https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."autovt@tty1".enable = false;
  systemd.services."getty@tty1".enable = false;

  # --- KDE-Specific ---

}
