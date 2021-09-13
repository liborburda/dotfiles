# /etc/bash/bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
  # Shell is non-interactive.  Be done now!
  return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

# Base
PS1='\[\033]0;\u@\h:\w\007\]'
# User + hostname
PS1+="\[\033[01;32m\]\u@\h "
# PWD
PS1+="\[\033[01;34m\]\w\[\033[m\] "
# Git branch
PS1+="\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')"
# kubectl current-context
#PS1+="\$( kubectl config current-context 2>/dev/null | awk '{ print \$0\" \" }' )"
# Final dollar
PS1+="\[\033[01;34m\]\$\[\033[00m\] "

mt() {
  mosh $1 -- tmux new -ADs 0
}

alias mnt='udisksctl mount -b'
alias umnt='udisksctl unmount -b'
alias cal='cal -y -m -w'

if [ -x "$(command -v kubectl)" ]; then
  source <(kubectl completion bash)
fi

if [ -x "$(command -v helm)" ]; then
  source <(helm completion bash)
fi

if [ -x "$(command -v eksctl)" ]; then
  source <(eksctl completion bash)
fi
