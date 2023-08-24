{ inputs, self, config, lib, pkgs, ... }:
{
  imports = [
  ];
  # NOTE: 󰈙  󰑭   󰜢     󰉋   󰙅   󰈇   󰆕   󰏘   󰎠      󰌋            󰊕    󰉿   󰀫      󰠱

  programs.nixvim.plugins.todo-comments = {
    keywords = {
      PERF    = {icon=" "; alt=[ "OPTIM" "PERFORMANCE" "OPTIMIZE" ]; };
      FIX     = {icon=" "; color="error";   alt=["FIXME" "BUG" "FIXIT" "ISSUE"];}; # Sign, search res icon. Color=hex|named. Alt keywords to map
      TODO    = {icon=" "; color="info";    alt=["LATER" "REMINDER"]; };
      HACK    = {icon=" "; color="warning"; alt=["JANK" "JANKY" "TEMPORARY"]; };
      WARN    = {icon=" "; color="warning"; alt=["WARNING" "XXX" "ALERT"]; };
      NOTE    = {icon=" "; color= "hint";   alt=["INFO" "HINT" "TIP"]; };
      TEST    = {icon="⏲ "; color= "test";   alt=["PASS" "FAIL" "PASSED" "FAILED" "TESTING"]; };
      WIP     = {icon="⏲";  color="test";    alt=["IN_PROGRESS" "UNFINISHED" ]; }; # TODO: Progress icon,
      ERROR   = {icon="x";  color="error";   alt=["ERR" "BROKEN"]; }; # TODO: x icon
      ARG     = {icon="󰀫";  color="gray";    alt=["ARGUMENT" "PARAM" "PARAMETER"]; };
      BUY     = {icon="$";  color="green";   alt=["PURCHASE"]; };
      CALC    = {icon="󰏿";  color="blue";    alt=["CALCULATE" "CALCULATED" "CALCULATEME" "FORMULA" "MATH"];};
      CONFIG  = {icon="";  color="blue";    alt=["CONF" "CONFIGURE" "SETTINGS" "OPTIONS" "CONFIGME" "CHANGE_CONFIG" "OPT_SET"];};
      DATE    = {icon="⏲";  color="info";    alt=["TIME" "TIMESTAMP" "LAST_VISITED" "LAST_UPDATED" "WHEN"]; };
      DEC     = {icon="󰆕";  color="info";    alt=["DECREASE" "DECREMENT"];};
      DIR     = {icon="󰉋";  color="info";    alt=["LOCATION" "FOLDER" "PARENT" "DIRECTORY" "DPATH"]; };
      SAMPLE  = {icon="";  color="green";   alt=["EX" "EXAM" "EXAMPLE" "SNIPPET" "SNIP"];};
      FILE    = {icon="󰈙";  color="info";    alt=["LOCATION" "PATH" "FILE_PATH" "FPATH"]; };
      FUNC    = {icon="󰊕";  color="gray";    alt=["FUNCTION" "FN" "FUNC_SIG" "SIGNATURE" "FUNC_DEF"]; };
      INC     = {icon="󰆕";  color="info";    alt=["INCREASE" "INCREMENT"];};
      IP      = {icon="";  color="green";   alt=["IP_ADDR" "NETWORK" "HOST"]; };
      LINK    = {icon="󰈇";  color="blue";    alt=["REPO" "PAGE" "SEE"   ]; };  # TODO: Hyperlink icon
      MOVE    = {icon="󰙅";  color="yellow";  alt=["MV"  "MOVEME" "RENAME" "CHDIR"]; };
      OLD     = {icon="⏲";  color="info";    alt=["OUTDATED" "UNMAINTAINED" "OUT_OF_DATE"]; };
      ORDER   = {icon="";  color="info";    alt=["REORG" "ORGANIZE" "REORDER" "REORGANIZE" "SORT" "SORTME"]; };
      PKG     = {icon="󰆧";  color="blue";    alt=["PACKAGE" "PKGS" "DEP" "DEPS" "LIBS" "PACKAGES" "DEPENDS" "DEPENDENCY" "DEPENDENCIES" "INSTALL" "INSTALLER"]; };
      SECRET  = {icon="󰌋"; color="orange";   alt=["SHH" "SHHH" "SENSITIVE" "HIDE" "HIDDEN" "KEY" "PASSWORD" "PW"]; };
      LATER   = {icon="⏲"; color="info";     alt=["FUTURE"];};  # TODO: Hourglass icon
      LAYOUT  = {icon="󰙅"; color="info";     alt=["STRUCTURE" "ORGANIZATION" "SCHEME"]; };
      TAG     = {icon="󰜢"; color="orange";   alt=["LABEL" "CATEGORY" "ATTRIBUTE"];};
      THEME   = {icon="󰏘"; color="purple";   alt=["COLOR" "THEMEME" "CHANGE_THEME" "CHANGE_COLOR" "CHANGE_THEME" "PRETTIFY"];};
      UPDATE  = {icon="󰆧"; color="red";      alt=["UPGRADE"]; };
      HELP    = {icon="?"; color="red";      alt=["HELPME" "ASK" "QUESTION"]; };
      #REMOVED = {icon=""; color="error"; alt=["DEPRECATED" "DELETED" "OBSOLETE"]; };  # TODO: Old/repair icon
      #LEARN = {icon=""; color="warning"; alt=["READ"];                 };  # TODO: Brain/book icon
      #DOC   = {icon=""; color="hint";    alt=["DOCS" "DOCUMENTATION"]; };  # TODO: Book/pencil|write icon, Docs link vs. needs-documentation
      #IDEA  = {icon=""; color="info";    alt=["FEATURE"             ]; };  # TODO: Lightbulb icon
      #DOWNLOAD = {icon=""; color="green"; alt=["DL"                 ]; };  # TODO: Download icon
      #READY = {icon=""; color="green"; alt=["COMPLETE" "DONE" "FINISHED" "FINAL"]; };

    };

  };
}
