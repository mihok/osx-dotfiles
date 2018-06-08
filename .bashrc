#
# ~/.bashrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# load colours

[[ -f ~/.bash_colors ]] && . ~/.bash_colors


# application shortcuts

alias tmux='tmux -2'

# utility aliases

alias ls='ls -G'
alias grep='grep --colour=always'

# terminal options

shopt -s histappend checkwinsize nocaseglob

# terminal title
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

    # Show the currently running command in the terminal title:
    # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
    show_command_in_title_bar()
    {
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command is trying to set the title bar as well;
                # this is most likely the execution of $PROMPT_COMMAND.
                # In any case nested escapes confuse the terminal, so don't
                # output them.
                ;;
            *)
                echo -ne "\033]0;${USER}@${HOSTNAME}: ${BASH_COMMAND}\007"
                ;;
        esac
    }
    trap show_command_in_title_bar DEBUG
    ;;
*)
    ;;
esac

# terminal colours

GRAY="\[$c234\]"
LIGHT_GRAY="\[$c240\]"
WHITE="\[$c255\]"

# PS1='[\u@\h \W]\$ '
PS1="$GRAY[\t] $WHITE\u $LIGHT_GRAY\w$GRAY> $LIGHT_GRAY"
