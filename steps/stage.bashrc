PS1='$ '
set +m   # no job control: avoids "setpgid: Operation not permitted" noise inside lookatme
# Exit after the first command, so the slide gets the keyboard back without Ctrl+A.
PROMPT_COMMAND='[ -n "$ran" ] && exit; ran=1'
