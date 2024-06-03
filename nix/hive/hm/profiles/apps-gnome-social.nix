{ inputs, cell, config, lib, pkgs, ... }: {
  imports = [
    # --- FOSS ---------------------------------------------
    cell.homeProfiles.app-gnome-lemoa
    cell.homeProfiles.app-gnome-lemonade
    cell.homeProfiles.app-gnome-tuba

    # --- Proprietary --------------------------------------
  ];

  home.packages = [
    #pkgs.giara #         # Reddit   # Build: 11/23: Dep python311Packages.prawcore build fails
    pkgs.headlines # # Reddit
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
