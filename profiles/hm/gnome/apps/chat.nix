{ inputs
, config
, lib
, pkgs
, ...
}:
{

  imports = [
    ../../apps/chat-pidgin
    ../../apps/chat-discord
    ../../apps/chat-twitch

    # --- SMS ----------------
    #../../apps/chat-sms
    ./chatty

    # --- XMPP ---------------
    #../../apps/chat-xmpp
    ./dino

    # --- Signal -------------
    ../../apps/chat-signal
    ./flare

    # --- Matrix -------------
    ../../apps/chat-matrix
    ./fractal
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
