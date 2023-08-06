# launch nvim in a loop until nvim exits with a non-zero exit code (:cq).
# useful when you want to make changes to nvim config and quickly restart nvim.
# this is easier if you use auto-session.
while true; do
  cp ~/.config/nvim/lazy-lock.json ~/.local/share/chezmoi/dot_config/nvim/
  chezmoi apply
  nvim
  if [ $? -ne 0 ]; then
    break
  fi
done
