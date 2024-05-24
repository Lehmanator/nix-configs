{ inputs, config, lib, pkgs, ... }: {
  imports = [
    ../../apps/chat-pidgin
    ../../apps/chat-discord
    ../../apps/chat-twitch

    # --- SMS ----------------
    #../../apps/chat-sms
    inputs.self.homeProfiles.app-gnome-chatty

    # --- XMPP ---------------
    #../../apps/chat-xmpp
    inputs.self.homeProfiles.app-gnome-dino

    # --- Signal -------------
    ../../apps/chat-signal
    inputs.self.homeProfiles.app-gnome-flare

    # --- Matrix -------------
    ../../apps/chat-matrix
    inputs.self.homeProfiles.app-gnome-fractal
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
