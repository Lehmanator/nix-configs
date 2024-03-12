{ inputs, config, lib, pkgs, ... }: {
  imports = [
    #./chat.nix
    #../../../apps/social.nix

    # --- FOSS ---------------------------------------------
    inputs.self.homeProfiles.app-gnome-lemoa
    inputs.self.homeProfiles.app-gnome-lemonade
    inputs.self.homeProfiles.app-gnome-tuba

    # --- Proprietary --------------------------------------
    inputs.self.homeProfiles.app-gnome-gtkcord
    inputs.self.homeProfiles.app-gnome-paperplane
    inputs.self.homeProfiles.app-chatterino
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
