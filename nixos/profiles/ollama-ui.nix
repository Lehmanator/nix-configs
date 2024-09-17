{ config, lib, pkgs, ... }:
{
  services.nextjs-ollama-llm-ui = {
    enable = true;
    hostname = "0.0.0.0";
    ollamaUrl = "42.45.244.197:11434";
    port = 11435;
  };
}
