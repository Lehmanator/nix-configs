{ inputs
, config
, lib
, pkgs
, ...
}:
{
  imports = [
    #./chat.nix
    #../../../apps/social.nix

    # --- FOSS ---------------------------------------------
    ./lemoa #       # Lemmy
    ./lemonade #    # Lemmy
    ./tuba #        # Mastodon

    # --- Proprietary --------------------------------------
    ./gtkcord #     # Discord
    #./headlines #  # Reddit
    ./paper-plane # # Telegram
    ./chatterino # Twitch
  ];

  home.packages = [
    #pkgs.giara #         # Reddit   # Build: 11/23: Dep python311Packages.prawcore build fails
    pkgs.headlines #      # Reddit
    pkgs.telegram-desktop # Telegram
    #pkgs.cawbird #       # Twitter (deprecated)
    # --- Bumble --------
    # --- Facebook ------
    # --- Hacker News ---
    # --- Instagram -----
    # --- Snapchat ------
    # --- Tinder --------
    # --- Tumblr --------

    # --- Decentralized ------------------------------------
    #../../apps/chat-matrix  # Matrix
    # --- Friendica -----
    # --- PixelFed ------
  ];

}
