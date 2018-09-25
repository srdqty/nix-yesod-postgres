#!/usr/bin/env bash

_build_prompt() {
  local reset_colors datetime user working_dir git_status line2

  reset_colors='\[$(tput sgr0)\]'

  datetime="\[$(tput setaf 150)\]\\D{%F %T}"
  user=" \[$(tput setaf 255)\] ❤${name}-nix-shell❤"
  working_dir=" \[$(tput setaf 162)\]\\w"
  git_status="\[$(tput setaf 6)\]\$(__git_ps1)"
  line2="\\n\[$(tput setaf 4)\]λx. ${reset_colors}"

  export PS1="${datetime}${user}${working_dir}${git_status}${line2}"
  export GIT_PS1_SHOWDIRTYSTATE=1
}

_build_prompt
unset _build_prompt
