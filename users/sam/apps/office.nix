{ pkgs, ... }: {
  imports = [];

  home.packages = with pkgs; [
    libreoffice-fresh
  ];
}
