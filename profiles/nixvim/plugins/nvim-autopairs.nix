{
config, lib, pkgs
, ...
}:
{

  # --- Pairs ------------------------
  # Insert, remove, highlight syntax pairs
  plugins.nvim-autopairs = {
    enable = false;

    enableAbbr             = false;  # Enable trigger abbreviations. D=f
    enableAfterQuote       = true;   #
    enableBracketInQuote   = true;   #
    enableCheckBracketLine = true;   #
    enableMoveright        = true;   # Enable moveright

    breakUndo = true;  # Switch for basic rule break undo sequence. D=true

    disableInMacro       = false;   # Disable when recording/executing macro
    disableInReplaceMode = true;    # Disable in mode: Replace
    disableInVisualblock = false;   # Disable in mode: Visual Block

    disabledFiletypes = [           # Named filetypes to disable autopairs
      "TelescopePrompt"
      "spectre_panel"
    ];

    mapBs = lib.mkDefault true;    # Map <BS>  to delete pair. D=true
    mapCH = lib.mkDefault false;   # Map <C-h> to delete pair. D=false
    mapCr = lib.mkDefault true;    # Map <CR>  to delete pair. D=true
    mapCW = lib.mkDefault true;    # Map <C-w> to delete pair. D=false

    checkTs = config.programs.nixvim.plugins.treesitter.enable;  # Use Treesitter to check for a pair. D=false
    #tsConfig = { lua=["string" "source"]; javascript=["string" "template_string"]; };  # D=null. Opts: null | attrset<list<str>>

    #extraOptions = {};
    #ignoredNextChar = "[=[[%w%%%'%[%"%.%%$]]=]`";
    #pairs = {};      # Chars to pair up. Opts: null | attrset<str>

  };

}
