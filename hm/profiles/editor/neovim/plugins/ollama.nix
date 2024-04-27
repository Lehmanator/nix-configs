{
  config,
  lib,
  pkgs,
  ...
}: {
  # https://github.com/nomnivore/ollama.nvim
  # TODO: Create keybinds to activate
  # TODO: Integrate with lualine
  programs.nixvim.plugins.ollama = {
    enable = true;
    #package = pkgs.vimPlugins.ollama-nvim;

    # How to handle prompt outputs when not specified by prompt.
    #  See: https://github.com/nomnivore/ollama.nvim/tree/main#actions
    #  Options: replace | insert | display_replace | display_insert | display_prompt | <submodule>
    #  Default: display
    action = "display";

    # Model to use when not specified by prompt.
    #  Default: mistral
    model = "dolphin-mixtral";

    # URL to use to connect to the ollama server.
    #  Default: http://127.0.0.1:11434
    url = config.home.sessionVariables.OLLAMA_HOST;

    # These attrs will be added to the table parameter for the setup function.
    #  Typically, it can override NixVim’s default settings.
    extraOptions = {
      #  display = true; # Whether to display the response.
      #  insert = false; # Whether to insert the response at the cursor
      #  replace = false; # Whether to replace the selection w/ the response. Precedes `insert`
      #  show_prompt = false; # Whether to prepend display buffer w/ the parsed prompt.
      #  window = "float";  # *float | split | vsplit

      # Tokens:
      # - $input = prompt the user for input
      # - $sel   = current or previous selection
      # - $ftype = filetype of the current buffer
      # - $buf   = full contents of the current buffer
      # - $line  = current line in the buffer
      # - $lnum  = current line number in the buffer
      prompts = {
        chat = rec {
          # Action to take w/ the response from the LLM.
          #  See: https://github.com/nomnivore/ollama.nvim?tab=readme-ov-file#actions
          action = "display";

          # Label to use for the input prompt.
          #  Default: "> "
          input_label = "Chat: mixtral > ";

          # Model to use for the prompt.
          #  Default: programs.nixvim.plugins.ollama.model
          model = "dolphin-mixtral";

          # The prompt to send to the LLM.
          #  Can contain special tokens that are substituted with context before sending
          #  See: The prompt to send to the LLM. Can contain special tokens that are substituted with context before sending
          prompt = "$input";

          # Lua match pattern to extract from the response. Only used by certain actions.
          #  See: https://github.com/nomnivore/ollama.nvim?tab=readme-ov-file#extracting
          #extract = ""; # false;

          # The format to return a response in. Currently the only accepted value is "json"
          #format = "json";

          # Additional model parameter overrides, such as temperature.
          #  See: https://github.com/jmorganca/ollama/blob/main/docs/modelfile.md#valid-parameters-and-values
          #options = {};

          # System prompt to be used in Modelfile template, if applicable.
          #system = "";
        };

        # Code Completion Models:
        # - stable-code: https://ollama.com/library/stable-code (python, C++, JS, Java) - 3B, fill-in-the-middle
        # - CodeLLama: https://ollama.com/library/codellama (Rust, PHP, JS) - 7B
        code_complete = {
          prompt = "Complete the following code.";
          model = "codellama"; # "codellama:7b-instruct" "codellama:7b-code" "codellama:7b-python";
          input_label = "> "; # Label to use for the input prompt.
          action = {
            display =
              true; # Stream and display the response in a floating window.
            replace = false; # Replace the current selection with the response.
            insert = true; # Insert the response at the current cursor line
            display_replace =
              false; # Stream and display the response in a floating window, then replace the current selection with the response.
            display_insert =
              false; # Stream and display the response in a floating window, then insert the response at the current cursor line.
          };
        };

        # TODO: Prompt to explain code step-by-step with comments.
        # TODO: Insert code instead of display.
        code_instruct = {
          action = "display";
          model = "codellama:7b-instruct";
          input_label = "Code Instruct: codellama > ";
          prompt = ''
            You are an expert programmer that writes simple, concise code and explanations.
            Write $ftype code to do the following:
            $input
          '';
        };

        # TODO: Figure out how to deal with suffix. Parse pre-input before/after current line/selection?
        code_infill = {
          action = "insert";
          model = "codellama:7b-code";
          input_label = "Code Infill: codellama > ";
          prompt = "<PRE> $buf <SUF> {suffix} <MID>";
        };

        code_review = {
          action = "display";
          model = "codellama";
          input_label = "Code Review: codellama > ";
          prompt = ''
            Where is the bug in this $ftype code?:
            $sel
          '';
        };

        code_complete_input = {
          action = "insert";
          model = "codellama:7b-code";
          input_label = "Code Complete: codellama > ";
          prompt = "$input";
        };
        code_complete_selection = {
          action = "insert";
          model = "codellama:7b-code";
          input_label = "Code Complete: codellama > ";
          prompt = "$sel";
        };
        code_complete_function_comment = {
          action = "insert";
          model = "codellama:7b-code";
          input_label = "Code Complete: codellama > ";
          prompt = "# Simple $ftype code to $line ";
        };
      };
    };
  };
}
