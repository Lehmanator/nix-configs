{ inputs, cell, config, lib, pkgs, ... }: {
  imports = with cell.homeProfiles; [
    #app-pidgin
    #app-discord
    #app-twitch

    # --- SMS ----------------
    # gnome-app-chatty

    # --- XMPP ---------------
    gnome-app-dino

    # --- Signal -------------
    # gnome-app-flare

    # --- Matrix -------------
    # gnome-app-fractal
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
