{ config, lib, pkgs
, ...
}:
{
  # FIXME: Broken bc pkgs.gnome.gnome-keyring renamed to pkgs.gnome-keyring
  # home.sessionVariables.SSH_AUTH_SOCK = lib.mkIf config.services.gnome-keyring.enable "$XDG_RUNTIME_DIR/keyring/ssh";
  # services.gnome-keyring = {
  #   enable = true;
  #   components = [ "pkcs11" "secrets" "ssh" ];
  # };
}
