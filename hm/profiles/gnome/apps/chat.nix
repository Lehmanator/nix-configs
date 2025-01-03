{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    # --- SMS ----------------
    ./chatty

    # --- XMPP ---------------
    ./dino

    # --- Signal -------------
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
