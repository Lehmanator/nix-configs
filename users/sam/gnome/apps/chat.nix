{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
  ];

  home.packages = [
    pkgs.chatty #pkgs.chatty-gtk4
    pkgs.dino # XMPP client
    pkgs.flare-signal # Signal client
    pkgs.fractal-next # Matrix client
    #pkgs.pidgin       # TODO: Add libpurple/pidgin plugins
  ];

}
