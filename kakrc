hook global WinCreate .* %{addhl number_lines}
set global ui_options ncurses_assistant=none

def surround %!on-key %@exec %sh&
  case "$kak_key" in
  "<lt>") key="<" ;;
  "<gt>") key=">" ;;
  "<space>") key=" " ;;
  "<tab>") key="\t" ;;
  \<*\>) echo ":echo<space>no<ret>"; exit 1 ;;
  *) key="$kak_key" ;;
  esac

  open="$key"
  close="$key"
  case "$key" in
  ")") open="(" ;;
  "]") open="[" ;;
  "}") open="{" ;;
  ">") open="<" ;;
  "(") open="( "; close=" )" ;;
  "[") open="[ "; close=" ]" ;;
  "{") open="{ "; close=" }" ;;
  "<") open="< "; close=" >" ;;
  esac

  epilogue=${close//?/H}

  open=${open/</<lt>}
  close=${close/>/<gt>}

  open=${open/ /<space>}
  close=${close/ /<space>}
  
  echo "i$open<esc>a$close<esc>$epilogue"
&@!

def delete-surround %!on-key %@exec %sh&
  echo "<a-a>${kak_key}s${kak_key}<ret>d"
&@!

map global user s ":surround<ret>"
