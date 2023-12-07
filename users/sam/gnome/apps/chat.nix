{ self
, inputs
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
    ./chatty

    # --- XMPP ---------------
    ./dino

    # --- Signal -------------
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
