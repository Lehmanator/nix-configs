{ inputs, config, lib, pkgs, ... }:
{
  imports = [
    ../apps/chat-discord
    ../apps/chat-twitch
  ];

}
