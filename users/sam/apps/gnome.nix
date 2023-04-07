{ pkgs, ... }: {
  home.packages = with pkgs; [
    fragments
  ];
}
