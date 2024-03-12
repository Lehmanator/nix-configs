{ inputs, config, lib, pkgs, ... }: {
  home.packages = [
    pkgs.caprine-bin # FB Messenger desktop client
    #pkgs.nur.repos.kira-bruneau.caprine   # FB Messenger desktop client

    pkgs.nchat # Terminal client for Telegram & WhatsApp
    #pkgs.whatsapp-for-linux
    #pkgs.whatsapp-emoji-font
    #pkgs.whatsapp-chat-exporter
    pkgs.zapzap # Linux WhatsApp client
  ];
}
