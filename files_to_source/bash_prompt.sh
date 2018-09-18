#!/usr/bin/env bash

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM='xterm-256color';
fi;

prompt_git() {
  local s='';
  local branchName='';

  # Check if the current directory is in a Git repository.
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

      # Ensure the index is up to date.
      git update-index --really-refresh -q &>/dev/null;

      # Check for uncommitted changes in the index.
      if ! $(git diff --quiet --ignore-submodules --cached); then
        s+='+';
      fi;

      # Check for unstaged changes.
      if ! $(git diff-files --quiet --ignore-submodules --); then
        s+='!';
      fi;

      # Check for untracked files.
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then
        s+='?';
      fi;

      # Check for stashed files.
      if $(git rev-parse --verify refs/stash &>/dev/null); then
        s+='$';
      fi;

    fi;

    # Get the short symbolic ref.
    # If HEAD isn�~@~Yt a symbolic ref, get the short SHA for the latest commit
    # Otherwise, just give up.
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
      git rev-parse --short HEAD 2> /dev/null || \
      echo '(unknown)')";

    [ -n "${s}" ] && s=" [${s}]";

    echo -e "${1}${branchName}${blue}${s}";
  else
    return;
  fi;
}

bold=''
reset='\e[0m'
RED="\[\033[0;31m\]"
YELLOW="\[\033[1;33m\]"
ORANGE="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
CYAN="\[\033[1;36m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
COLOR_NONE="\[\e[0m\]"

# Highlight if the user is root
if [[ "${USER}" == "root" ]]; then
    userStyle="${bold}${GREEN}";
else
    userStyle="${GREEN}"
fi;

# Highlight if the TTY is through an SSH session
if [[ "${SSH_TTY}" ]]; then
    hostStyle="${bold}${GREEN}";
else
    hostStyle="${GREEN}";
fi;

# Set the terminal title to the current working directory.
PS1=""
if [[ "${SSH_TTY}" ]]; then
    PS1+="\[${ORANGE}\](ssh) ";
fi;
if [[ "${USER}" == "root" ]]; then
    PS1+="\[${RED}\[(root) "
fi;

PS1+="\[${userStyle}\]\u"; # username
PS1+="\[${GREEN}\]@";
PS1+="\[${hostStyle}\]\h"; # host
PS1+="\[${WHITE}\]:";
PS1+="\[${BLUE}\]\W"; # working directory
PS1+="\$(prompt_git \"  ${LIGHT_GREEN}\")"; # Git repository details
PS1+="\[${BLUE}\] \$ \[${reset}\]"; # `$` (and reset color)
export PS1;
