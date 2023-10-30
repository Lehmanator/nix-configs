{ inputs, self
, pkgs, lib, config
, user ? "sam"
, ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager
  ];

  home.persistence."/persist/home/${user}" = {
    hideMounts = true;
    # TODO: Use relevant config options to set (e.g. "${home.xdg.configHome}/k9s"
    directories = [
      #config.xdg.configHome
      config.xdg.dataHome
      config.xdg.stateHome

      "Backups"
      "Books"
      "Code"
      "Documents"
      "Downloads"
      "Games"
      "Music"
      "Pictures"
      "Videos"

      ".gnupg"
      ".mozilla"
      ".ssh"
      ".nixops"
      ".local/bin"

      #".local/share/keyrings"
      #".local/share/direnv"

      ".var/app"  # Flatpaks

    ] ++ lib.optional (builtins.elem pkgs.element-desktop config.home.packages) "${config.xdg.configHome}/Element";

    files = [
      ".screenrc"
    ];

    # Allow other users, such as root, to access files thru the bind-mounted directories listed in `directories`.
    #  Useful for `sudo` operations, Docker, etc.
    #  Note: Requires NixOS option: `programs.fuse.userAllowOther = true`
    allowOther = true;

  };

}
