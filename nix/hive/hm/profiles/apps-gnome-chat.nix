{ inputs, cell, config, lib, pkgs, ... }: {
  imports = [
    #cell.homeProfiles.app-pidgin
    #cell.homeProfiles.app-discord
    #cell.homeProfiles.app-twitch

    # --- SMS ----------------
    # cell.homeProfiles.app-gnome-chatty

    # --- XMPP ---------------
    cell.homeProfiles.app-gnome-dino

    # --- Signal -------------
    # cell.homeProfiles.app-gnome-flare

    # --- Matrix -------------
    # cell.homeProfiles.app-gnome-fractal
  ];

  home.packages = [
    # --- FOSS ---------------------------------------------

    # --- Multi-Protocol -----
    #pkgs.pidgin       # TODO: Add libpurple/pidgin plugins

    # --- Proprietary --------------------------------------
    # --- Facebook Messenger ---
    # --- Instagram DMs --------
    # --- Twitter DMs ----------
    # --- WhatsApp -------------
  ];
}
