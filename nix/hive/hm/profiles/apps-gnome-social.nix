{ cell, pkgs, ... }: {
  imports = [
    # --- FOSS ---------------------------------------------
    cell.homeProfiles.gnome-app-lemoa
    cell.homeProfiles.gnome-app-lemonade
    cell.homeProfiles.gnome-app-tuba

    # --- Proprietary --------------------------------------
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
