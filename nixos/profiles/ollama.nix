{pkgs, ...}: {
  services.ollama = {
    enable = true;
    listenAddress = "45.42.244.197:11434";
  };
}
