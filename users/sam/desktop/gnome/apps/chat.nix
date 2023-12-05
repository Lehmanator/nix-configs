{ self
, inputs
, config
, lib
, pkgs
, ...
}:
{

  imports = [
    ../../apps/chat.nix

    # --- SMS ----------------
    ./chatty

    # --- XMPP ---------------
    ./dino

    # --- Signal -------------
    ./flare

    # --- Matrix -------------
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
