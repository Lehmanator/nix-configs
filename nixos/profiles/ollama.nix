{...}: {
  services.ollama = {
    enable = true;
    # listenAddress = "45.42.244.197:11434";
    # port = 11434;
  };

  environment.sessionVariables.OLLAMA_HOST = "45.42.244.197:11434";
  networking.hosts."45.42.244.197" = ["ollama.sea1"];

  # 24.11 / unstable only
  # services.nextjs-ollama-llm-ui = {
  #   enable = true;
  #   ollamaUrl = "http://" + config.environment.sessionVariables.OLLAMA_HOST;
  #   hostname = "0.0.0.0";
  #   port = "11030";
  # };
}
