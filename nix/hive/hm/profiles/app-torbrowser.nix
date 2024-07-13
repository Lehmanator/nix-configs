{ config , lib , pkgs , ... }: {
  home.packages = lib.mkIf (pkgs.system == "x86_64-linux") [ pkgs.tor-browser-bundle-bin ];
}
