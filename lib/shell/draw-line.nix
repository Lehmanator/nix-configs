{pkgs, ...}@args: msg: beg: sep: end: let
  len = toString (1 + builtins.stringLength (beg + msg + end));
  #COLUMNS=$(${pkgs.ncurses}/bin/tput cols)
  #DIVIDER_COLS="$(( COLUMNS - ${len} ))"
  #printf -- "${sep}%.0s" "$(${pkgs.coreutils}/bin/seq $DIVIDER_COLS)"
in ''
  read -r LINES COLUMNS < <(stty size)
  printf "${beg + sep + msg}"
  printf -- "${sep}%.0s" $(${pkgs.coreutils}/bin/seq "$(( COLUMNS - ${len} ))")
  printf '${end}\n'
''
