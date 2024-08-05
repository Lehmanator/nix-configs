{ config, lib, pkgs, ... }:
{
  environment.sessionVariables.OLLAMA_HOST = "45.42.244.197:11434";

  services.ollama = {
    enable = true;
    # listenAddress = "45.42.244.197:11434";
    # port = 11434;
  };

  # 24.11 / unstable only
  # services.nextjs-ollama-llm-ui = {
  #   enable = true;
  #   ollamaUrl = "http://" + config.environment.sessionVariables.OLLAMA_HOST;
  #   hostname = "0.0.0.0";
  #   port = "11030";
  # };

  services.tabby = rec {
    enable = true;
    port = 11029;
    # port = (config.services.ollama.port or 11434) + 1;

    # https://github.com/TabbyML/registry-tabby
    model = "TabbyML/DeepseekCoder-6.7B";

    settings = {
      model = {
        completion.http = {
          kind = "ollama/completion";
          model_name = "codellama:7b";
          prompt_template = "<PRE> {prefix} <SUF>{suffix} <MID>";  # Example prompt template for CodeLlama model series.
          api_endpoint = "http://${config.environment.sessionVariables.OLLAMA_HOST}";
          # api_endpoint = "http://45.42.244.197:11434";
        };
        #chat.http = {
        #  kind = "ollama/chat";  
        #};
        #embedding.http = {
        #  kind = "ollama/embedding";  
        #};
      };
      
      # Repos to index
      # repositories = [
      #   { name = "nix-configs"; git_url = "https://github.com/Lehmanator/nix-configs"; }

      #   # { name = "tabby"; git_url = "https://github.com/TabbyML/tabby.git"; }
      #   # { name = "CTranslate2"; git_url = "git@github.com:OpenNMT/CTranslate2.git"; }

      #   # # local directory is also supported, but limited by systemd DynamicUser=1
      #   # # adding local repositories will need to be done manually
      #   # { name = "repository_a"; git_url = "file:///var/lib/tabby/repository_a"; }
      # ];
    };

  };

  systemd.services = rec {
    tabby.environment = {
      TABBY_ROOT = "%S/tabby";
      TABBY_DISABLE_USAGE_COLLECTION = "1";
      # TABBY_WEBSERVER_JWT_TOKEN_SECRET = "";
      OLLAMA_HOST = config.environment.sessionVariables.OLLAMA_HOST;
      # OLLAMA_HOST = "http://${config.services.ollama.listenAddress}";
      # OLLAMA_HOST = "http://45.42.244.197:11434";
    };

    # Fix for upstream being broken
    tabby-scheduler = {
      preStart = "cp -f /etc/tabby/config.toml \${TABBY_ROOT}/config.toml && mkdir -p \${TABBY_ROOT}/index";
      environment.RUST_BACKTRACE = "1";
    };

    # Support LSPs
    # TODO: Configure: ~/.tabby-client/agent/config.toml
    tabby-agent = {
      description = "Tabby client agent for LSP completion.";
      environment = tabby.environment;
      preStart = "cp -f /etc/tabby/agent/config.toml \${TABBY_ROOT}/config.toml";
      after = ["network.target"];
      wants = ["tabby.service"];
      serviceConfig = {
        WorkingDirectory = "/var/lib/tabby";
        StateDirectory = ["tabby"];
        ConfigurationDirectory = ["tabby"];
        DynamicUser = true;
        User = "tabby";
        Group = "tabby";
        ExecStart = "${lib.getExe pkgs.nodePackages.nodejs} exec tabby-agent -- --stdio";
      };
    };
  };

  # TODO: Configure Helix to import
  environment.etc = {
    "tabby/agent/config.toml".source = (pkgs.formats.toml {}).generate "config.toml" {
      server = {
        endpoint = "http://localhost:${builtins.toString config.services.tabby.port}";
      };
    };
    "tabby/agent/helix.toml".text = ''
      [language-server.tabby]
      command = "npx"
      args = ["tabby-agent", "--stdio"]

      # Add Tabby as the second language server for your specific languages
      [[languages]]
      name = "typescript"
      language-servers = ["typescript-language-server", "tabby"]

      [[languages]]
      name = "toml"
      language-servers = ["taplo", "tabby"]
    '';
  };
}
