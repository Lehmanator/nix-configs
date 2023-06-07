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
  ];

  home.packages = [
    # --- FOSS ---------------------------------------------

    # --- Multi-Protocol -----
    pkgs.chatty
    #pkgs.chatty-gtk4  # TODO: Create overlay with GTK4 patches
    #pkgs.pidgin       # TODO: Add libpurple/pidgin plugins

    # --- Matrix -------------
    pkgs.fractal-next

    # --- Signal -------------
    pkgs.flare-signal

    # --- XMPP ---------------
    pkgs.dino


    # --- Proprietary --------------------------------------
    # --- Facebook Messenger ---
    # --- Instagram DMs --------
    # --- Twitter DMs ----------
    # --- WhatsApp -------------

  ];

}
