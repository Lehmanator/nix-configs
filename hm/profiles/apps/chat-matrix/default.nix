{ pkgs, ... }:
{
  imports = [
    #./cinny.nix
    ./element.nix
    #./fluffychat.nix
    #./neko.nix
    #./schlidichat.nix
    #./syphon.nix
  ];
  services.flatpak.packages = ["chat.schildi.desktop"];
}
