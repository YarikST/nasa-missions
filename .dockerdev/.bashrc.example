# aliases
alias ll='ls -alFGh'

# arrow up/down arrays for history search
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

HISTFILESIZE=1000000000
HISTSIZE=1000000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# correct minor errors in the spelling of a directory component in a cd command
shopt -s cdspell

# save all lines of a multiple-line command in the same history entry (allows easy re-editing of multi-line commands)
shopt -s cmdhist

# grep colorize
export GREP_OPTIONS="--color=auto"
export USER=`whoami`

# settings for appending commands to history from all terminals in
# parallel
function enable_parallel_history {
  history -a; history -c; history -r;
}
enable_parallel_history

# setup color variables
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  color_is_on=true
  color_red="\[$(/usr/bin/tput setaf 1)\]"
  color_green="\[$(/usr/bin/tput setaf 2)\]"
  color_yellow="\[$(/usr/bin/tput setaf 3)\]"
  color_blue="\[$(/usr/bin/tput setaf 6)\]"
  color_white="\[$(/usr/bin/tput setaf 7)\]"
  color_gray="\[$(/usr/bin/tput setaf 8)\]"
  color_off="\[$(/usr/bin/tput sgr0)\]"

  color_error="$(/usr/bin/tput setab 1)$(/usr/bin/tput setaf 7)"
  color_error_off="$(/usr/bin/tput sgr0)"

  # set user color
  case `id -u` in
    0) color_user=$color_red ;;
    *) color_user=$color_green ;;
  esac
fi

# set prompt command (title update and color prompt & git branch status)
export DOCKER_NOTE="local-docker"

function set_prompt_command {

  local PWDNAME=$PWD

  # beautify working directory name
  if [[ "${HOME}" == "${PWD}" ]]; then
    PWDNAME="~"
  elif [[ "${HOME}" == "${PWD:0:${#HOME}}" ]]; then
    PWDNAME="~${PWD:${#HOME}}"
  fi

  # calculate prompt length

  local PS1_length=$((${#DOCKER_NOTE}+${#USER}+${#HOSTNAME}+${#PWDNAME}+4))
  local FILL=

  # if length is greater than terminal width
  if [[ $PS1_length -gt $COLUMNS ]]; then
    # strip working directory name
    PWDNAME="...${PWDNAME:$(($PS1_length-$COLUMNS+3))}"
  else
    # else calculate fillsize
    local fillsize=$(($COLUMNS-$PS1_length))
    FILL=$color_gray
    while [[ $fillsize -gt 0 ]]; do FILL="${FILL}─"; fillsize=$(($fillsize-1)); done
    FILL="${FILL}${color_off}"
  fi

  # set new color prompt
  PS1="${color_user}\u@${color_green}${DOCKER_NOTE}-${color_yellow}${HOSTNAME}:${color_white}${PWDNAME}${color_yellow}${color_off} ${FILL}\nλ "

}

PROMPT_COMMAND=set_prompt_command
