setopt prompt_subst # enable command substition in prompt

NEWLINE=$'\n'
PROMPT='${NEWLINE}%n@%m${git_branch_name} %~${NEWLINE}# '
RPROMPT='' # no initial prompt, set dynamically


# Show Git branch/tag, or name-rev if on detached head
function parse_git_branch() {
  (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}


# Asynchronously update RPROMPT in case the process takes a while
# https://www.anishathalye.com/2015/02/07/an-asynchronous-shell-prompt/

function rpromptcmd() {
  parse_git_branch
}

ASYNC_PROC=0
function precmd() {
  function async() {
    # save to temp file
    printf "%s" "$(rpromptcmd)" > "/tmp/zsh_prompt_$$"

    # signal parent
    kill -s USR1 $$
  }

  RPROMPT="[?$RPROMPT?]"

  # kill child if necessary
  if [[ "${ASYNC_PROC}" != 0 ]]; then
    kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
  fi

  # start background computation
  async &!
  ASYNC_PROC=$!
}

function TRAPUSR1() {
  # read from temp file
  RPROMPT="$(cat /tmp/zsh_prompt_$$)"

  # reset proc number
  ASYNC_PROC=0

  # redisplay
  zle && zle reset-prompt
}
