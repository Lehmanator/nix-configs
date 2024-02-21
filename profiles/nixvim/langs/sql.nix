{
  config,
  lib,
  pkgs,
  ...
}: {
  # https://ollama.com/library/sqlcoder
  # https://github.com/nix-community/nixvim/blob/main/templates/simple/flake.nix
  plugins.ollama = {
    extraOptions.prompts = {
      sqlcoder-from-schema = {
        action = "display";
        input_label = "sqlcoder > ";
        model = "sqlcoder";
        prompt = ''
          ### Instructions:
          Your task is to convert a question into a SQL query, given a Postgres database schema.
          Adhere to these rules:
          - **Deliberately go through the question and database schema word by word** to appropriately answer the question
          - **Use Table Aliases** to prevent ambiguity. For example, `SELECT table1.col1, table2.col1 FROM table1 JOIN table2 ON table1.id = table2.id`.
          - When creating a ratio, always cast the numerator as float

          ### Input:
          Generate a SQL query that answers the question `{$input}`.
          This query will run on a database whose schema is represented in this string:
          {$buf}

          ### Response:
          Based on your instructions, here is the SQL query I have generated to answer your question:
          ```sql
        '';
      };
    };
  };
}
