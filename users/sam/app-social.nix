{ self, inputs, system, config, lib, pkgs, ... }: let
in {
  imports = [
    #./app-chat.nix
  ];

  # TODO: Move purple/pidgin plugins to ./app-chat.nix
  home.packages = with pkgs; [

    # --- Purple Plugins ---

    # OMEMO Encryption for libpurple
    purple-lurch

    # Plugin for SMS via ModemManager
    purple-mm-sms

    # Plugin for HTTP file upload over XMPP protocol
    purple-xmpp-http-upload

    # Collection of plugins for purple clients
    purple-plugin-pack

    purple-discord
    purple-facebook
    purple-googlechat
    purple-hangouts
    purple-slack
    purple-vk-plugin
    tdlib-purple

    purple-matrix
    purple-signald

    # --- Pidgin Plugins ---
    pidgin-carbons
    pidgin-latex
    pidgin-indicator
    pidgin-msn-pecan
    pidgin-opensteamworks
    pidgin-skypeweb
    pidgin-window-merge
    pidgin-xmpp-receipts
    #gnomeExtensions.pidgin-im-integration
  ];


  # TODO: Add browser webapps for missing social networks

}
