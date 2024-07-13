{config, pkgs, ...}: {
  environment.sessionVariables.OLLAMA_HOST="45.42.244.197:11434";
  # environment.sessionVariables.OLLAMA_HOST="${config.services.ollama.host}:${builtins.toString config.services.ollama.port}";
  # services.ollama = {
  #   enable = true;
  #   host = "45.42.244.197";
  #   port = 11434;
  # };
}
