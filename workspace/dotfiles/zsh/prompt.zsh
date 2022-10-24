# enable command substition in prompt
setopt prompt_subst 

# enables use of `$fg_bold[green]` and $reset_color etc
# see `which colors` for more
autoload -Uz colors && colors

source "$(dirname "$0")/git-prompt.sh"

local NEWLINE=$'\n'
PROMPT='${NEWLINE}$fg[blue]%n@%m$reset_color $bg[white]$fg[black] %~ $reset_color$fg[yellow]$(__git_ps1 " (%s)")$reset_color ${NEWLINE}# '
