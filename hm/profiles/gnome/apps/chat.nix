{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ../../apps/chat-pidgin

    # --- SMS ----------------
    #../../apps/chat-sms
    ./chatty

    # --- XMPP ---------------
    #../../apps/chat-xmpp
    ./dino

    # --- Signal -------------
    ../../apps/chat-signal
    ./flare
  ];

  home.packages = [
    # --- Multi-Protocol -----
    #pkgs.pidgin       # TODO: Add libpurple/pidgin plugins

    # --- Proprietary --------------------------------------
    # --- Facebook Messenger ---
    # --- Instagram DMs --------
    # --- Twitter DMs ----------
    # --- WhatsApp -------------
  ];
}
