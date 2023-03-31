{ pkgs, ... }: {
  home.packages = with pkgs; [
    fractal-next
    fragments
  ];
}
