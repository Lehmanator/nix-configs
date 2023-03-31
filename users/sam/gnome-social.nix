{ self, inputs, system, config, lib, pkgs, ... }: let
in {
  imports = [
    #./gnome-chat.nix
  ];

  home.packages = with pkgs; [

    # --- Proprietary --------------------------------------

    # --- Discord -------
    gotktrix4
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
    # --- Snapchat ------
    # --- Telegram ------
    # --- Tinder --------
    # --- Tumblr --------
    # --- Twitch --------


    # --- Decentralized ------------------------------------

    # --- Friendica -----
    # --- Lemmy ---------
    # --- Mastodon ------
    # --- Matrix --------
    # --- PixelFed ------

  ];
}
