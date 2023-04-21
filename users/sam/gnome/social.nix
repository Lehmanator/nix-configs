{ self, inputs, system, config, lib, pkgs, ... }:
{
  imports = [
    #./gnome-chat.nix
    ./apps/social.nix
  ];

  home.packages = with pkgs; [

    # --- Proprietary --------------------------------------

    # --- Discord -------
    gotktrix
    gtkcord4

    # --- Reddit --------
    giara
    headlines

    # --- Twitter -------
    cawbird

    # --- Bumble --------
    # --- Facebook ------
    # --- Hacker News ---
    # --- Instagram -----
    # --- Signal --------
    signal-desktop
    # --- Snapchat ------
    # --- Telegram ------
    # --- Tinder --------
    # --- Tumblr --------
    # --- Twitch --------


    # --- Decentralized ------------------------------------

    # --- Friendica -----
    # --- Lemmy ---------
    # --- Mastodon ------
    tootle

    # --- Matrix --------
    element-desktop
    fractal-next

    # --- PixelFed ------

  ];
}
