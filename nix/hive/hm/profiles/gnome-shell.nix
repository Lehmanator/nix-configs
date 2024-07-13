{ pkgs, ... }: {
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = blurt; }
      { package = m3u8-play; }
      { package = wiggle; }
    ];
    #theme = {
    #  name = "";
    #  package = pkgs.;
    #};
  };
}
