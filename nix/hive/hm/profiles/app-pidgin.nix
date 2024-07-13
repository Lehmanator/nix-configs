{ config, lib, pkgs, ... }: {
  # TODO: Move purple/pidgin plugins to ./app-chat.nix
  home.packages = [
    # --- Purple Plugins ---

    # OMEMO Encryption for libpurple
    pkgs.purple-lurch

    # Plugin for SMS via ModemManager
    pkgs.purple-mm-sms

    # Plugin for HTTP file upload over XMPP protocol
    pkgs.purple-xmpp-http-upload

    # Collection of plugins for purple clients
    pkgs.purple-plugin-pack

    pkgs.purple-discord
    pkgs.purple-facebook
    pkgs.purple-googlechat
    pkgs.purple-hangouts
    pkgs.purple-slack
    pkgs.purple-vk-plugin
    #pkgs.tdlib-purple

    pkgs.purple-matrix
    pkgs.purple-signald

    # --- Pidgin Plugins ---
    pkgs.pidgin-carbons
    pkgs.pidgin-latex
    pkgs.pidgin-indicator
    pkgs.pidgin-msn-pecan
    pkgs.pidgin-opensteamworks
    pkgs.pidgin-skypeweb
    pkgs.pidgin-window-merge
    pkgs.pidgin-xmpp-receipts
    #gnomeExtensions.pidgin-im-integration
  ];

  # TODO: Add browser webapps for missing social networks
}
