# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

check_package() {
    if [ "$(dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep -c 'ok installed')" -eq 0 ];
    then
        pkg install "$1" -y;
    fi
}

printf "${BLUE}%s${NORMAL}\n" "Updating DarkFB Premium"
check_package coreutils
#check_package figlet
if git pull origin master
then
  #printf '%s' "$GREEN"
  #printf '%s\n' 'DarkFB'
  printf "${BLUE}%s\n" "Hooray! DarkFB has been updated and/or is at the current version."
  printf "${BLUE}${BOLD}%s${NORMAL}\n" "More information at: https://github.com/JeelsBoobz/DarkFB"
else
  printf "${RED}%s${NORMAL}\n" 'There was an error updating. Try again later?'
fi
